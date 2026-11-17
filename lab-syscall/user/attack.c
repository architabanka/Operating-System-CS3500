#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"
#include "kernel/riscv.h"

#define MEM (50*4096)

int
main(int argc, char *argv[])
{
  char *buf;
  char *offset="This may help.";
  int n=strlen(offset);

  buf=sbrk(MEM);
  if(buf==(char *)-1){
    printf("Memory allocation failed\n");
    exit(1);
  }

  for(int pos=0;pos+n+16<MEM;pos++){
    int match=1;
    for(int k=0;k<n;k++){
      if(buf[pos+k]!=offset[k]){
        match=0;
        break;
      }
    }

    if(match){
      printf("%s\n",buf+pos+16);
      exit(0);
    }
  }
  exit(1);
}