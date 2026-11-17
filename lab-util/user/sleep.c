#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(2, "Incorrect Usage specify : sleep ticks\n");
        exit(1);
    }
    int tm = atoi(argv[1]);
    pause(tm);
    exit(0);

    
    
}