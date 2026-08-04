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

% Cerrar todas las ventanas de figuras.
close all;

%% Cargar el paquete simbólico

% Cargar el paquete necesario para realizar cálculo simbólico.
pkg load symbolic

%% Reglas recomendadas

% Regla 1:
% Si se necesita evaluar una función numéricamente,
% utilizar funciones numéricas (evitar el uso de subs).

% Regla 2:
% Si se necesita derivar o manipular expresiones,
% utilizar variables y funciones simbólicas.

%% Opción 1: Convertir texto a una expresión simbólica

% Declarar la variable simbólica.
syms x

% Definir la función como una cadena de texto.
f_text = 'exp(x)+4*x';

% Convertir el texto a una expresión simbólica.
f_sym = sym(f_text);

% Calcular la derivada simbólica.
der_f = diff(f_sym);

%% Opción 2: Convertir texto a una función numérica

% Crear una función anónima a partir de la cadena de texto.
f_num = str2func(['@(x)' f_text]);

% Evaluar la función en x = 5.
f_num(5);

%% Opción 3: Convertir una función simbólica a una función numérica

% Convertir la derivada simbólica en una función numérica.
df_num = matlabFunction(der_f);

% Evaluar la derivada en x = 5.
df_num(5);
