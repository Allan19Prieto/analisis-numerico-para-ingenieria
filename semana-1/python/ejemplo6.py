
import sympy as sp
import numpy as np


##############################################################################
# Definición de variables simbólicas
##############################################################################

# Declarar la variable simbólica x.
x = sp.symbols("x")


##############################################################################
# Opción 1: Convertir texto a una expresión simbólica
##############################################################################

# Definir la función como una cadena de texto.
f_text = "exp(x) + 4*x"

# Convertir el texto a una expresión simbólica.
f_sym = sp.sympify(f_text)

# Mostrar la expresión simbólica.
print("Simbólico:", f_sym)


##############################################################################
# Opción 2: Convertir texto a una función numérica
##############################################################################

# Crear una función numérica a partir de la cadena de texto.
f_num = lambda x: eval(f_text, {"x": x, "exp": np.exp})

# Evaluar la función en x = 1.
print("Numérico (desde texto):", f_num(1))


##############################################################################
# Opción 3: Convertir una función simbólica a una función numérica
##############################################################################

# Convertir la función simbólica en una función numérica.
f_num2 = sp.lambdify(x, f_sym, modules=["numpy"])

# Evaluar la función en x = 1.
print("Numérico (desde simbólico):", f_num2(1))