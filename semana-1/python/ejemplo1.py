
import numpy as np

##############################################################################
# Operaciones básicas con matrices
##############################################################################

# Generar una matriz aleatoria de tamaño 10x15.
A = np.random.rand(10, 15)

# Generar una matriz aleatoria de tamaño 15x15.
B = np.random.rand(15, 15)

# Multiplicar las matrices A y B.
C = np.dot(A, B)

##############################################################################
# Estructura condicional
##############################################################################

# Valor utilizado para el ejemplo.
t = 10

# Verificar si el valor es menor que 15.
if t < 15:
    print("El número es menor a 15")
else:
    print("El número es mayor o igual a 15")

##############################################################################
# Vectores
##############################################################################

# Crear un vector fila.
vect = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

# Obtener el vector columna equivalente.
vect_trans = np.expand_dims(vect, axis=1)

#print(vect)
# Para la transpuesta, se puede utilizar la función np.transpose().
#print(np.transpose(vect_trans))

# Crear un vector desde 1 hasta 100 con incremento de 1.
vec1 = np.arange(1, 101)

# El profe evalua en el examen

# Crear un vector desde 0 hasta 100 con incremento de 5.
vec2 = np.arange(0, 101, 5)

##############################################################################
# Ciclo for
##############################################################################

# Generar las primeras diez potencias de 2 mediante comprensión de listas.
vec3 = np.array([2**k for k in range(1, 11)])

# Inicializar un vector de ceros.
vec4 = np.zeros(10)

# Almacenar potencias de 2 utilizando un ciclo for.
for k in range(1, 10):
    vec4[k] = 2**k
print(vec4)

##############################################################################
# Ciclo while
##############################################################################

# Inicializar las variables para calcular el primer factorial
# cuyo valor sea mayor o igual que 1000.
n = 1
nFactorial = 1

while nFactorial < 1000:
    n += 1
    nFactorial *= n

# Mostrar el resultado obtenido.
print(nFactorial)