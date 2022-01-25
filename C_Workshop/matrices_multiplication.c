#include "matrices_multiplication.h"

int main() {

    int n = 4;

    int** matrice = malloc(sizeof(int*)*n);
    int* matrice_data = malloc(sizeof(int)*n*n);

    for (int i = 0; i < n; i++) {
        matrice[i] = &matrice_data[i*n];
    }
    
    int** matrice_2 = malloc(sizeof(int*)*n);
    int* matrice_2_data = malloc(sizeof(int)*n*n);
    int** result = malloc(sizeof(int*)*n);
    int* result_data = malloc(sizeof(int)*n*n);

    for (int i = 0; i < n; i++) {
        matrice[i] = &matrice_data[i*n];
        matrice_2[i] = &matrice_2_data[i*n];
        result[i] = &result_data[i*n];
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            matrice[i][j] = i;
            matrice_2[i][j] = j;
        }
    }
    printf("Matrise 1:\n");
    printMatrice(matrice, n);
    printf("Matrise 2:\n");
    printMatrice(matrice_2, n);


    matrices_multiplication(matrice, matrice_2, result, n);

    printMatrice(result, n);

    free(matrice_data);
    free(matrice);
    free(matrice_2_data);
    free(matrice_2);
    free(result_data);
    free(result);
}

