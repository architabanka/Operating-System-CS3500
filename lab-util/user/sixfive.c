#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int
main(int argc, char* argv[])
{
    if(argc < 2){
        fprintf(2,"Incorrect Usage. Specify file name.");
        exit(1);
    }   
    for(int i=1;i<argc;i++){
        int fd = open(argv[i],0);
        if(fd < 0){
            fprintf(2,"Invalid file.");
            exit(1);
        }
        char c;
        int num=0, valid=0, prevsep=1;

        while (read(fd, &c, 1) == 1) {
            if (c>='0'&&c<='9'){
                if(prevsep){
                    num=num*10+(c-'0');
                    valid=1;
                }
            }
            else if(strchr(" -\r\t\n./,", c)){
                if(valid&&prevsep) {
                    if((num%5==0) || (num%6==0)) 
                        printf("%d\n",num);
                }
                num=0;
                valid=0;
                prevsep=1;
            }
            else {
                valid=0;
                num=0;
                prevsep=0;
            }
        }
        if (prevsep && valid) {
            if (num%5 == 0 || num%6 == 0)
                printf("%d\n", num);
        }

        close (fd);
    }
    exit (0);
}