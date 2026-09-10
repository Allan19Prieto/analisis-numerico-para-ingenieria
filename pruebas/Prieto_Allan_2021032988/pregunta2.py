import sympy as sp
import numpy as np
import matplotlib.pyplot as plt

# Varible simbolica
x = sp.symbols('x')
f = x**4 - 4*x**3 - 2*x**2 + 12*x +5

# Primera y segunda derivada
f_p_derivada = sp.diff(f, x)
f_s_derivada = sp.diff(f_p_derivada, x)

print("Primera derivada:", f_p_derivada)
print("Segunda derivada:", f_s_derivada)

# resolver simbolicamente f'(x) = 0 y obtener los puntos críticos
puntos_criticos = sp.solve(f_p_derivada, x)
print("Puntos críticos:", puntos_criticos)

puntos_permitidos = []
for punto in puntos_criticos:
    if -2 <= punto.evalf() <= 4:
        puntos_permitidos.append(punto)

print("Puntos críticos permitidos prueba:", puntos_permitidos)

# e) Evalúe f en todos los puntos críticos admisibles y también en los extremos x = −2 y x = 4
extremos = [-2, 4]
print(puntos_permitidos)
puntos_permitidos += extremos
print(puntos_permitidos)

evaluaciones = []

for puntos in puntos_permitidos:
    evaluaciones.append((puntos, f.subs(x, puntos)))

print(evaluaciones)


# minimos y maximos absolutos
minimo = evaluaciones.index(min(evaluaciones))
maximo = evaluaciones.index(max(evaluaciones))
print(minimo, maximo)

x_min = puntos_permitidos[minimo]
f_min = evaluaciones[minimo]

x_max = puntos_permitidos[maximo]
f_max = evaluaciones[maximo]
print(f_min, f_max)

#puntos_criticos= []
# clasificar puntos criticos en f''
for punto in puntos_permitidos:
    punto_critico =f_s_derivada.subs(x, punto)
    if punto_critico > 0:
        print(f"{punto} es un minimo local")
    elif punto_critico < 0:
        print(f"{punto} es un maximo local")
    else:
        print(f"{punto} no se permite incluir")

# convertir f a numerica
f_en_numerica = sp.lambdify(x, f, 'numpy')

# grafica de la funcion
eje_x = np.linspace(-2, 4, 500)
eje_y = f_en_numerica(eje_x)

plt.plot(eje_x, eje_y, label="f(x)")

plt.show()


print("\nPuntos criticos en el intervalo:", puntos_permitidos)

print("\nMinimo absoluto:")
print("x =", x_min)
print("f(x) =", f_min)

print("\nMaximo absoluto:")
print("x =", x_max)
print("f(x) =", f_max)
