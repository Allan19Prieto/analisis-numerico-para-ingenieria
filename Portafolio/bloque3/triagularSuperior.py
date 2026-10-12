import numpy as np

def sust_atras(A, b):
    n = A.shape[0]
    x = np.zeros(n)

    #Recorrer desde la última fila hasta la primera
    for i in range(n-1, -1,  -1):
        aux = 0

        for j in range(i+1, n):
            aux = aux + A[i, j] * x[j]

        x[i] = (b[i] - aux) / A[i, i]

    return x

def ejemplo_triangular():
    A = np.array([
        [1, 1, -1, 3],
        [0, -1, -1, -5],
        [0, 0, 3, 13],
        [0, 0, 0, 13]
    ], dtype=float)

    b = np.array([4, -7, 13, -13], dtype=float)

    x = sust_atras(A, b)
    r = b - A @ x
    err = np.linalg.norm(r)

    print("Solución x: ", x)
    print("Norma del residuo: ", err)

if __name__ == "__main__":
    ejemplo_triangular()