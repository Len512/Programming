//
//  main.c
//  Cmd Line Tests
//

#include <stdio.h>
#include <time.h>

int main(int argc, const char * argv[]) {
    
    long secondsFromNow = 4000000 + time(NULL); // time now + seconds to count
    struct tm in4MillionSeconds;
    localtime_r(&secondsFromNow, &in4MillionSeconds);
    printf("In 4 million seconds it will be %d/%d/%d\n", in4MillionSeconds.tm_mday, in4MillionSeconds.tm_mon + 1, in4MillionSeconds.tm_year + 1900);
    
    return 0;
}
