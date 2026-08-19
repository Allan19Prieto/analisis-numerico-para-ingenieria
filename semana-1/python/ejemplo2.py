
import math


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

    return b**2 - 4*a*c


def cuadratica(a, b, c):
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
    x1 = (-b + math.sqrt(disc)) / (2 * a)

    # Calcular la segunda raíz.
    x2 = (-b - math.sqrt(disc)) / (2 * a)

    ##########################################################################
    # Salida de la función
    ##########################################################################

    # Devolver las dos raíces en una lista.
    return [x1, x2]


##############################################################################
# Ejemplo de uso
##############################################################################

# Resolver la ecuación x² + 2x + 1 = 0.
print(cuadratica(1, 2, 1))