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

function x = cuadratica(a,b,c)
% CUADRATICA Resuelve una ecuación cuadrática.
%
%   x = CUADRATICA(a,b,c) calcula las dos raíces de la ecuación
%
%       a*x^2 + b*x + c = 0
%
%   Entradas:
%       a : Coeficiente del término cuadrático.
%       b : Coeficiente del término lineal.
%       c : Término independiente.
%
%   Salida:
%       x : Vector fila con las dos raíces de la ecuación,
%           x = [x1 x2].
%
%   Ejemplo:
%       x = cuadratica(1,1,-6)

    %% Cálculo del discriminante

    % Calcular el discriminante de la ecuación cuadrática.
    d = b^2 - 4*a*c;

    %% Cálculo de las raíces

    % Calcular la primera raíz.
    x1 = (-b + sqrt(d))/(2*a);

    % Calcular la segunda raíz.
    x2 = (-b - sqrt(d))/(2*a);

    %% Salida de la función

    % Almacenar las dos raíces en un vector fila.
    x = [x1 x2];

end
