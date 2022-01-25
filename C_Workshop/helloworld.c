#include <stdio.h>
#include <stdlib.h>

int main() {
	int a = 3;
	int* b = &a;
	int** c = &b;

	printf("a : %d\n", &a);
	printf("*b : %d\n", b);
	printf("**c : %d\n", c);

	int array[5];
	array[0] = 5;
	array[1] = 3;

	int* dynamic_memory = malloc(sizeof(int)*5);

	printf("peker til minne : %d\n", dynamic_memory);


	for (int i = 0; i < 5; i++) {
		dynamic_memory[i] = i;
		printf("innhold i minne : %d\n", dynamic_memory[i + 5]);
	}

	return 0;
}
