#include "fft.h"

/**
 * This file contains the implementation of `fft_compute` and ancillary
 * functions.
 */

// Include for math functions and definition of PI
#include <math.h>
// Included to get access to `malloc` and `free`
#include <stdlib.h>

// Forward declaration of helper methods
void get_even(const complex* in, complex* out, const int n, int type) {
	for(int i = 0; i < n / 2; i++) {
		// Transfer all the even indexed numbers to the output array
		
		if (type == 0)
			out[i] = in[2 * i];
		else
			out[i] = in[2 * i + 1];
	}
}

void get_odd(const complex* in, complex* out, const int n) {
	for(int i = 0; i < n / 2; i++) {
		// Transfer all the odd indexed numbers to the output array
		out[i] = in[2 * i + 1];
	}
}

void fft_compute(const complex* in, complex* out, const int n, int input) {
	if(n == 1) {
		out[0] = in[0];
	} else {
		const int half = n / 2;
		// First we declare and allocate arrays
		// Allocate enough room for half the input values
		
		complex* even_out = malloc(sizeof(complex) * half);
		complex* odd_out  = malloc(sizeof(complex) * half);
		// Extract even and odd indexed numbers using methods above
		get_even(in, even, n, 0);
		
		
		// Recursively calculate the result for bottom and top half
		fft_compute(even, even_out, n / 2, input + 2);
		get_even(in, even, n, 1);
		
		fft_compute(odd, odd_out, n / 2, input - input + 1);
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
