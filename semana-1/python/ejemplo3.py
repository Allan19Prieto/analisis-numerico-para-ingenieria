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


def ejemplo_cuadratica():
    """
    Ejecuta un ejemplo numérico para resolver una ecuación cuadrática.

    Esta función corresponde al programa principal. Las funciones auxiliares
    utilizadas para resolver el problema se encuentran definidas más abajo.
    """

    ##########################################################################
    # Definición de los coeficientes
    ##########################################################################

    # Coeficientes de la ecuación ax² + bx + c = 0.
    a = 1
    b = 1
    c = -6

    ##########################################################################
    # Resolver la ecuación cuadrática
    ##########################################################################

    # Obtener las dos raíces de la ecuación.
    x = cuad(a, b, c)

    ##########################################################################
    # Mostrar el resultado
    ##########################################################################

    # Imprimir las soluciones.
    print(f"La solución es {x[0]} y {x[1]}")


##############################################################################

# LOs comentarios de las funciones con la correcta estructura
# me ayudan a usar help() y ver la documentacion de la funcion, ademas de que me ayuda a entender mejor el codigo
def cuad(a, b, c):
    """
    Resuelve una ecuación cuadrática.

    Parámetros
    ----------
    a : float
        Coeficiente del término cuadrático.
    b : float
        Coeficiente del término lineal.
    c : float
        Término independiente.

    Retorna
    -------
    list
        Lista con las dos raíces de la ecuación.
    """

    ##########################################################################
    # Cálculo del discriminante
    ##########################################################################

    # Calcular el discriminante de la ecuación cuadrática.
    disc = discriminante(a, b, c)

    ##########################################################################
    # Cálculo de las raíces
    ##########################################################################

    # Calcular la primera raíz.
    x1 = (-b + np.sqrt(disc)) / (2 * a)

    # Calcular la segunda raíz.
    x2 = (-b - np.sqrt(disc)) / (2 * a)

    ##########################################################################
    # Salida de la función
    ##########################################################################

    # Devolver las dos raíces en una lista.
    return [x1, x2]


##############################################################################


def discriminante(a, b, c):
    """
    Calcula el discriminante de una ecuación cuadrática.

    Parámetros
    ----------
    a : float
        Coeficiente del término cuadrático.
    b : float
        Coeficiente del término lineal.
    c : float
        Término independiente.

    Retorna
    -------
    float
        Valor del discriminante.
    """

    return b**2 - 4 * a * c


##############################################################################
# Programa principal
##############################################################################
# Para tener la funcion principal, el profe quiere que le entregemos resultados de esta forma o como la del empjemplo 2, esta (3)
# es la mas ordenada....
if __name__ == "__main__":
    ejemplo_cuadratica()