import numpy as np
import matplotlib.pyplot as plt

# Definir la función original
def f(x):
    return np.log(np.arcsin(x)) / np.log(x)

# Creacion de los pares ordenados que nos dan
x = np.array([0.2, 0.4, 0.5, 0.7, 0.8])
y = f(x)

n =  len(x) # Tamaño de n

print("Valores de x: ")
print(x)

print("Valores de y: ")
print(y)

# La matriz del sistema
A = np.zeros((n, n)) 

for i in range(n):
    for j in range(n):
        A[i, j] = x[i] ** (n - 1 - j)

print("Matriz A: ")
print(A)

#Resolver el sistema para obtener los coeficientes
a = np.linalg.solve(A, y)

print("Coeficientes [a4, a3, a2, a1, a0]: ")
print(a)

#Si evaluamos el polinomio podemos evaluar 
def p(x):
    return np.polyval(a, x)

print("Funcion original en los nodos")
print(y)

print("Polinomio en los nodos")
print(p(x))

errores = np.abs(p(x) -y)

print("errores absolutos")
print(errores)

# Graficar la función y el polinomio
xx = np.linspace(0.2, 0.9, 400)

plt.figure(figsize=(9, 5))

plt.plot(xx, f(xx), label="Funcion original f(x)")
plt.plot(xx, p(xx), "--", label="Polinomio p4(x)")

plt.scatter(
    x, y,
    color="black",
    label="Puntos de interpolacion",
    zorder=3
)

plt.xlabel("x")
plt.ylabel("y")
plt.title("Interpolacion mediante un sistema de ecuaciones")

plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()