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

%% Funciones matemáticas básicas

% Calcular la raíz cuadrada de un número.
x = sqrt(2);

% Calcular el seno de un ángulo expresado en radianes.
y = sin(5);

% Calcular el seno de un ángulo expresado en grados.
z = sind(5);

%% Formato de visualización

% Mostrar un mayor número de cifras decimales.
% format long

% Mostrar un número reducido de cifras decimales.
% format short

%% Operaciones con matrices

% Generar una matriz cuadrada aleatoria de tamaño 4x4.
A = rand(4,4);

% Calcular la inversa de la matriz.
Ainv = A^-1;      % También puede utilizarse inv(A).

% Verificar que A*A^(-1) es aproximadamente la matriz identidad.
C = round(A*Ainv);

%% Precisión de máquina

% Obtener el valor del épsilon de máquina.
e = eps;

%% Sistema de ecuaciones lineales

% Definir la matriz de coeficientes.
A = [5 1 0;
     1 5 1;
     0 1 5];

% Definir el vector del lado derecho.
b = [-6;
     -7;
     -6];

% Resolver el sistema de ecuaciones A*x = b.
x = mldivide(A,b);      % Equivalente a x = A\b.

%% Determinante de una matriz

% Calcular el determinante de la matriz.
determinante = det(A);

%% Valores y vectores propios

% Calcular los valores propios y los vectores propios de la matriz.
[X,V] = eig(A);





