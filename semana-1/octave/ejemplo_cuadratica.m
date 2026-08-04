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

function ejemplo_cuadratica()

    %% Función principal
    % Esta función ejecuta un ejemplo numérico para resolver una
    % ecuación cuadrática. Las funciones auxiliares utilizadas en el
    % procedimiento se encuentran definidas al final del archivo.

    % Limpiar la ventana de comandos.
    clc;

    % Eliminar todas las variables almacenadas en memoria.
    clear;

    %% Definición de los coeficientes

    % Coeficientes de la ecuación ax^2 + bx + c = 0.
    a = 1;
    b = 1;
    c = -6;

    %% Resolver la ecuación cuadrática

    % Obtener las dos raíces de la ecuación.
    x = cuad(a,b,c);

    %% Mostrar el resultado

    % Imprimir las soluciones en la ventana de comandos.
    disp(['La solución es ', num2str(x(1)), ' y ', num2str(x(2))])

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = cuad(a,b,c)

    %% Cálculo de las raíces

    % Calcular el discriminante.
    d = disc(a,b,c);

    % Calcular la primera raíz.
    x1 = (-b + sqrt(d))/(2*a);

    % Calcular la segunda raíz.
    x2 = (-b - sqrt(d))/(2*a);

    % Almacenar ambas raíces en un vector fila.
    x = [x1 x2];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function d = disc(a,b,c)

    %% Cálculo del discriminante

    % Evaluar el discriminante de la ecuación cuadrática.
    d = b^2 - 4*a*c;

end

