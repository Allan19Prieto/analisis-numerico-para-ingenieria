
import sympy as sp
import numpy as np
import matplotlib.pyplot as plt


##############################################################################
# Definición de variables simbólicas
##############################################################################

# Declarar la variable simbólica x.
x = sp.symbols("x")


##############################################################################
# Simplificación de expresiones simbólicas
##############################################################################

# Definir dos expresiones simbólicas.
a = sp.sin(x)
b = sp.cos(x)

# Simplificar la expresión.
y = sp.simplify(a**2 + b**2)


##############################################################################
# Evaluación de expresiones simbólicas
##############################################################################

# Definir una expresión simbólica.
y = sp.cos(x) + sp.sin(x)

# Valor inicial.
z = 5

# Evaluar la expresión simbólica de forma iterativa.
w = y.subs(x, z)

for _ in range(10):
    # Convertir el resultado simbólico a un valor numérico.
    z = float(y.subs(x, z))

    # print(z)


##############################################################################
# Derivación simbólica
##############################################################################

# Definir una función simbólica.
f = sp.sqrt(sp.sin(x) * sp.log(x))

# Calcular la primera derivada.
fd = sp.diff(f, x)


##############################################################################
# Cálculo de límites
##############################################################################

# Definir una función simbólica.
g = sp.sin(x) / x

# Calcular el límite cuando x tiende a cero.
limite = sp.limit(g, x, 0)

# Ellimite se calcula con este comando


##############################################################################
# Gráfica de una función
##############################################################################

# En pyton tenemos que hacer unaadaptacion para graficar ya que no es como octave que es simbolico, en python tenemos que hacer una funcion numerica para graficar
# usar lambdify para convertir la funcion simbolica en una funcion numerica, y luego graficar con matplotlib

# Convertir la función simbólica en una función numérica.
g_func = sp.lambdify(x, sp.cos(x) + sp.sin(x), "numpy")

# Crear los valores para el eje x.
x_vals = np.linspace(-5, 5, 1000)

# Evaluar la función.
y_vals = g_func(x_vals)

# Graficar la función.
plt.plot(x_vals, y_vals, label="cos(x) + sin(x)")

# Dibujar los ejes coordenados.
plt.axhline(0, color="black", linewidth=0.5)
plt.axvline(0, color="black", linewidth=0.5)

# Agregar una leyenda.
plt.legend()

# Mostrar una cuadrícula.
plt.grid()

# Mostrar la figura.
plt.show()