%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CE1111: Análisis Numérico para Ingeniería
% Escuela de Ingeniería en Computadores
%
% Archivo de ejemplo para el curso.
%
% Autor: Dr. Juan Pablo Soto Quirós
% Todos los ejemplos de este archivo fueron creados por el autor con fines
% exclusivamente didácticos para apoyar el proceso de enseñanza y
% aprendizaje del curso CE1111: Análisis Numérico para Ingeniería.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicialización del entorno de trabajo

% Limpiar la ventana de comandos.
clc;

% Eliminar todas las variables almacenadas en memoria.
clear;

%% Operaciones básicas con matrices

% Generar una matriz aleatoria de tamaño 10x5.
A = rand(10,5);

% Generar una matriz aleatoria de tamaño 5x3.
B = rand(5,3);

% Multiplicar las matrices A y B.
C = A*B;

%% Estructura condicional

% Valor utilizado para el ejemplo.
t = 10;

% Verificar si el valor es menor que 15.
if t < 15
    disp('El número es menor a 15')
else
    disp('El número es mayor o igual a 15')
end

%% Vectores

% Crear un vector fila.
vect = [1 2 3 4 5 6 7 8 9 10];

% Obtener la transpuesta del vector.
vect_trans = vect.';

% Crear un vector desde 1 hasta 100 con incremento de 1.
vec1 = 1:100;

% Crear un vector desde 0 hasta 100 con incremento de 5.
vec2 = 0:5:100;

%% Ciclo for

% Inicializar un vector vacío.
vec3 = [];

% Almacenar las primeras diez potencias de 2.
for k = 1:10
    vec3 = [vec3 2^k];
end

%% Ciclo while

% Inicializar las variables para calcular el primer factorial
% cuyo valor sea mayor o igual que 1000.
n = 1;
nFactorial = 1;

while nFactorial < 1000
    n = n + 1;
    nFactorial = nFactorial * n;
end

% Mostrar el resultado obtenido.
nFactorial
