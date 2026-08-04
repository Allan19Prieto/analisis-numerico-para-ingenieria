##############################################################################
# CE1111: Análisis Numérico para Ingeniería
# Escuela de Ingeniería en Computadores
#
# Archivo de ejemplo para el curso.
#
# Autor: Dr. Juan Pablo Soto Quirós
# Todos los ejemplos de este archivo fueron creados por el autor con fines
# exclusivamente didácticos para apoyar el proceso de enseñanza y
# aprendizaje del curso CE1111: Análisis Numérico para Ingeniería.
##############################################################################

import numpy as np
import scipy.linalg as la
import scipy.optimize as opt


##############################################################################
# Funciones matemáticas básicas
##############################################################################

# Calcular la raíz cuadrada de un número.
x = np.sqrt(2)

# Calcular el seno de un ángulo expresado en radianes.
y = np.sin(5)


##############################################################################
# Operaciones con matrices
##############################################################################

# Generar una matriz cuadrada aleatoria de tamaño 4x4.
A = np.random.rand(4, 4)

# Calcular la inversa de la matriz A.
Ainv = np.linalg.inv(A)

# Verificar que A multiplicada por su inversa es aproximadamente
# la matriz identidad.
C = np.round(A @ Ainv)

# Mostrar el resultado.
print(C)


##############################################################################
# Sistema de ecuaciones lineales
##############################################################################

# Definir la matriz de coeficientes.
A = np.array([[5, 1, 0],
              [1, 5, 1],
              [0, 1, 5]])

# Definir el vector del lado derecho.
b = np.array([-6, -7, -6])

# Resolver el sistema de ecuaciones A*x = b.
x = np.linalg.solve(A, b)


##############################################################################
# Determinante de una matriz
##############################################################################

# Calcular el determinante de la matriz A.
determinante = np.linalg.det(A)


##############################################################################
# Definición de funciones numéricas
##############################################################################

def fun(x):
    """
    Evalúa la función f(x) = e^x - 2x - 10.

    Parámetros
    ----------
    x : float
        Valor en el cual se evalúa la función.

    Retorna
    -------
    float
        Valor de la función evaluada en x.
    """

    return np.exp(x) - 2*x - 10


##############################################################################
# Mínimo local de una función
##############################################################################

# Definir un valor inicial.
x0 = 3

# Calcular el punto donde la función alcanza un mínimo local.
xsol = opt.fmin(fun, x0, disp=False)


##############################################################################
# Solución de una ecuación no lineal
##############################################################################

# Definir un valor inicial.
x0 = -4

# Calcular una solución de la ecuación f(x) = 0.
xsol_root = opt.fsolve(fun, x0)


##############################################################################
# Mínimo de una función en un intervalo
##############################################################################

# Definir el intervalo de búsqueda.
a = -2
b = 2

# Calcular el mínimo de la función en el intervalo [a,b].
xmin = opt.fminbound(fun, a, b)


##############################################################################
# Máximo de una función en un intervalo
##############################################################################

def newfun(x):
    """
    Evalúa el negativo de la función fun.

    Esta función permite calcular un máximo de fun mediante un método
    de minimización.

    Parámetros
    ----------
    x : float
        Valor en el cual se evalúa la función.

    Retorna
    -------
    float
        Negativo del valor de fun evaluada en x.
    """

    return -fun(x)


# Definir el intervalo de búsqueda.
a = 0
b = 3

# Calcular el punto donde la función alcanza el máximo.
xmax = opt.fminbound(newfun, a, b)

# Mostrar el resultado.
print(xmax)


