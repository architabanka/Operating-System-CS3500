#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/fcntl.h"
#include "kernel/param.h"

int match(char*, char*);

void
find(char *path, char *filename, char** exec_args)
{
    int fd;
    fd=open(path, 0);
    if(fd<0){
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    struct stat st;
    int statt=fstat(fd, &st);
    if(statt<0){
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    if(st.type==(short)2){ // T_FILE
        char* name=path;
        char* p=path;
        while(*p){
            if(*p=='/'){
                name=p+1;
                p++;
            }
            else p++;
        }
        if(match(filename,name)){
            if(exec_args==0)printf("%s\n",path);
            else{
                char* argv[MAXARG];
                int i=0;
                while(exec_args[i]){
                    argv[i]=exec_args[i];
                    i++;
                }
                argv[i]=path;
                argv[i+1]=0;
                if(fork()==0){
                    exec(argv[0],argv);
                    fprintf(2,"exec %s failed\n",argv[0]);
                    exit(1);
                }
                wait(0);
            }
        }
    }
    else if(st.type==(short)1){ //T_DIR
        char buf[512];
        struct dirent de;
        if(strlen(path)+1+DIRSIZ+1>sizeof(buf)){
            printf("find: path too long\n");
            return;
        }
        strcpy(buf, path);
        char *p;
        p=buf+strlen(buf);
        *p++='/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0)continue;
            if(strcmp(de.name,".")==0|| strcmp(de.name,"..")==0) continue;
            memmove(p,de.name,DIRSIZ);
            p[DIRSIZ] = 0;
            find(buf, filename, exec_args);
        }

    }
    close(fd);
}

int main(int argc, char* argv[])
{
    char **exec_arg=0;
    if(argc==3){
        find(argv[1],argv[2], exec_arg);
    }
    else if(argc>=5 && strcmp(argv[3], "-exec")==0){
        exec_arg=&argv[4];
        find(argv[1],argv[2], exec_arg);
    }
    else{
        fprintf(2, "Usage: find <path> <filename> [-exec cmd args...]\n");
        exit(1);
    }
    exit(0);
}


int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}

