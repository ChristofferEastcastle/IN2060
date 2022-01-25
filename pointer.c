#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
typedef struct {
    int n;
} test;

void* foo(void* args) {
    test* tests = args;
	
	
	printf("%d\n", tests->n);  
}


int main() {
    test test;
    test.n = 32434;
    
    pthread_t tid;

    pthread_create(&tid, NULL, foo, (void*) &test);
    pthread_join(tid, NULL);
}