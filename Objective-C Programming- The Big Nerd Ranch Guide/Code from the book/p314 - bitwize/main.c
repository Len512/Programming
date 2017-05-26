//
//  main.c
//  bitwize
//  p314

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    unsigned char a = 0x3c;
    unsigned char b = 0xa9;
    
    // OR
    unsigned char c = a | b;
    printf("Hex: %x | %x = %x\n", a, b, c);
    printf("Decimal: %d | %d = %d\n", a, b, c);
    
    // AND
    unsigned char d = a & b;
    printf("Hex: %x & %x = %x\n", a, b, d);
    printf("Decimal: %d & %d = %d\n", a, b, d);
    
    // XOR
    unsigned char e = a ^ b;
    printf("Hex: %x ^ %x = %x\n", a, b, e);
    printf("Decimal: %d ^ %d = %d\n", a, b, e);
    
    // Complement
    unsigned char f = ~b;
    printf("Hex: The complement of %x is %x\n", b, f);
    printf("Decimal: The complement of %d is %d\n", b, f);
    
    // Left shift
    unsigned char g = a << 2;
    printf("Hex: %x shifted left two places is %x\n", a, g);
    printf("Decimal: %d shifted left two places is %d\n", a, g);
    
    // Right shift
    unsigned char h = a >> 1;
    printf("Hex: %x shifted right one place is %x\n", a, h);
    printf("Decimal: %d shifted right one place is %d\n", a, h);
    
    return 0;
}
