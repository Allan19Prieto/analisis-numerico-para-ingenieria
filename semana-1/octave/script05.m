
%% Inicialización del entorno de trabajo

% Limpiar la ventana de comandos.
clc;

% Eliminar todas las variables almacenadas en memoria.
clear;

% Cerrar todas las ventanas de figuras.
close all;

%% Cargar el paquete simbólico

% Cargar el paquete necesario para realizar cálculo simbólico.
pkg load symbolic

%% Definición de variables simbólicas

% Declarar la variable simbólica x.
syms x

%% Simplificación de expresiones simbólicas

% Definir dos expresiones simbólicas.
a = sin(x);
b = cos(x);

% Simplificar la expresión.
y = simplify(a^2 + b^2);

%% Evaluación de expresiones

% Definir una expresión simbólica.
y = cos(x) + sin(x);

% Definir la función numérica equivalente.
f1 = @(x1) cos(x1) + sin(x1);

% Valor inicial.
z = 5;

% Evaluar la función numérica de forma iterativa.
for k = 1:20
    % z = subs(y,z);    % Evaluación simbólica.
    z = f1(z);          % Evaluación numérica.
    % pause(0.1)
end

%% Derivación simbólica

% Definir una función simbólica.
g = sqrt(sin(x)*log(x));

% Calcular la primera derivada.
gd = diff(g);

% Calcular la segunda derivada.
gd2 = diff(g,2);

%% Gráfica de una función simbólica

% Graficar la función en el intervalo [1,50].
ezplot(g,[1 50]);



