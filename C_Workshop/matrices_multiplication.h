#include <stdlib.h>
#include <stdio.h>

void printMatrice(int** matrice, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d, ", matrice[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

void matrices_multiplication(int** matrice_1, int** matrice_2, int** result, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = 0;
            for (int k = 0; k < n; k++) {
                result[i][j] += matrice_1[i][k] * matrice_2[k][j];
            }
        }
    }
}
