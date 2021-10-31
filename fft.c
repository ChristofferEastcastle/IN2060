#include "fft.h"

/**
 * This file contains the implementation of `fft_compute` and ancillary
 * functions.
 */

// Include for math functions and definition of PI
#include <math.h>
// Included to get access to `malloc` and `free`
#include <stdlib.h>
// Including pthread for parallelization
#include <pthread.h>
#include <stdio.h>

// Struct for arguments to thread func
typedef struct {
	const int* n;
	complex* in;
	complex* out;
} arguments;

// Forward declaration of helper methods
void get_even(const complex* in, complex* out, const int n) {
	for(int i = 0; i < n / 2; i++) {
		// Transfer all the even indexed numbers to the output array
		out[i] = in[2 * i];
	}
}

void get_odd(const complex* in, complex* out, const int n) {
	for(int i = 0; i < n / 2; i++) {
		// Transfer all the odd indexed numbers to the output array
		out[i] = in[2 * i + 1];
	}
}

void* compute(void* argument_pointer) {
	arguments* args = argument_pointer;
	int n = *args->n;
	complex* in = args->in;
	complex* out = args->out;
	printf("%d\n", n);
	if(n == 1) {
		out[0] = in[0];
	} else {
		const int half = n / 2;
		// First we declare and allocate arrays
		// Allocate enough room for half the input values
		complex* even = malloc(sizeof(complex) * half);
		complex* odd  = malloc(sizeof(complex) * half);
		complex* even_out = malloc(sizeof(complex) * half);
		complex* odd_out  = malloc(sizeof(complex) * half);
		// Extract even and odd indexed numbers using methods above
		get_even(in, even, n);
		get_odd(in, odd, n);
		// Recursively calculate the result for bottom and top half
		fft_compute(even, even_out, n / 2);
		fft_compute(odd, odd_out, n / 2);
		// Combine the output of the two previous recursions
		for(int i = 0; i < half; ++i) {
			const complex e = even_out[i];
			const complex o = odd_out[i];
			const complex w = cexp(0 - (2. * M_PI * i) / n * I);
			out[i]        = e + w * o;
			out[i + half] = e - w * o;
		}
		// Since we allocated room for variables we need to release
		// the memory!
		free(even);
		free(odd);
		free(even_out);
		free(odd_out);
	}
}

void fft_compute(const complex* in, complex* out, const int n) {
	printf("%d\n", n);
	const int half = n / 2;
	complex* first_half = malloc(sizeof(complex)* half);
	complex* second_half = malloc(sizeof(complex)* half);
	complex* first_out = malloc(sizeof(complex)* half);
	complex* second_out = malloc(sizeof(complex)* half);
	
	for (int i = 0; i < n; i++) {
		if (i < half) first_half[i] = in[i];
		else second_half[i] = in[i];
	}
	
	arguments args = {&half, first_half, first_out};
	
	
	arguments args2;
	args2.n = &half;
	args2.in = second_half;
	args2.out = second_out;
	pthread_t tid[2];
	
	
	pthread_create(&tid[0], NULL, compute, (void*) &args);
	pthread_create(&tid[1], NULL, compute, (void*) &args2);
	
	for (int i = 0; i < 2; i++) {
		pthread_join(tid[i], NULL);
	}
	
	for (int i = 0; i < n; i++) {
		if (i < half) out[i] = first_out[i];
		else out[i] = second_out[i];
	}
	
	free(first_half);
	free(second_half);
	free(first_out);
	free(second_out);
}
