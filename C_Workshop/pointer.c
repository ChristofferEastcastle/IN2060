#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* n;
    
} args;


void* foo(void* arg) {
    args* args = arg;
    if (args->n == 1) return 1;

    
    

}

int main() {

    int integer = 69;
    char* string = "hello world!";
    args arguments = {&integer};

    
    int* arr = malloc(sizeof(int) * 100);

    for (int i = 10; i < 110; i++) arr[i - 10] = i;

    printf("%d\n", *arr + 100);

    free(arr);
    return 0;
}