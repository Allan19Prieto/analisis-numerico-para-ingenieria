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

%% Solución de una ecuación cuadrática

% Definir los coeficientes de la ecuación:
%   ax^2 + bx + c = 0
a = 5;
b = 3;
c = 4;

% Calcular el discriminante de la ecuación.
disc = b^2 - 4*a*c;

% Calcular la primera solución.
x1 = (-b + sqrt(disc))/(2*a);

% Calcular la segunda solución.
x2 = (-b - sqrt(disc))/(2*a);

%% Mostrar los resultados

% Imprimir la primera raíz.
disp(['Primera solución: x1 = ', num2str(x1)])

% Imprimir la segunda raíz.
disp(['Segunda solución: x2 = ', num2str(x2)])
