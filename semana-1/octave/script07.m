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

%% Definición de los datos

% Crear un vector de valores para el eje x.
ejex = 1:0.01:10;

% Evaluar la función cos(x) en cada punto del vector.
ejey = cos(ejex);

%% Gráfica de los datos

% Graficar únicamente los puntos.
% stem(ejex,ejey)

% Graficar la función uniendo los puntos mediante segmentos de recta.
plot(ejex,ejey)

%% Personalización de la gráfica

% Agregar un título a la figura.
title('Gráfica de f(x)=cos(x)')

% Etiquetar el eje horizontal.
xlabel('Eje x')

% Etiquetar el eje vertical.
ylabel('Eje y')
