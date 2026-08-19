
%% Inicialización del entorno de trabajo

% Limpiar la ventana de comandos.
clc;

% Eliminar todas las variables almacenadas en memoria.
clear;

% Cerrar todas las ventanas de figuras.
close all;

%% Funciones matemáticas predefinidas

% Calcular el logaritmo natural.
x = log(2);

% Calcular el logaritmo en base 10.
y = log10(5);

%% Definición de una función anónima

% Definir la función
%
%   f(x) = e^x - 2x - 10
%
% La expresión @(x) indica que la variable independiente de la función
% es x.
f1 = @(x) exp(x) - 2*x - 10;

%% Ejemplo 1: Búsqueda de un mínimo local

% Definir un valor inicial.
x0 = 1;

% Calcular el punto donde la función alcanza un mínimo local.
xmin = fminsearch(f1,x0);

% Evaluar la función en el punto encontrado.
ymin = f1(xmin);

%% Ejemplo 2: Solución de una ecuación no lineal

% Definir un valor inicial.
x0 = 5;

% Resolver la ecuación f(x)=0.
xsol = fzero(f1,x0);

%% Ejemplo 3: Mínimo de una función en un intervalo

% Definir el intervalo de búsqueda.
a = 2;
b = 4;

% Calcular el mínimo de la función en el intervalo [a,b].
xmin = fminbnd(f1,a,b);

%% Ejercicio: Máximo de una función en un intervalo

% Definir el intervalo de búsqueda.
a = 1;
b = 3;

% Reflejar la función respecto al eje x.
newf1 = @(x) -1*f1(x);

% Definir una función para calcular el máximo mediante fminbnd.
fmaxbnd = @(newf1,a,b) fminbnd(newf1,a,b);

% Calcular el punto donde la función alcanza el máximo.
xmax = fmaxbnd(newf1,a,b);



