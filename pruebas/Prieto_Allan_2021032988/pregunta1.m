
clc; clear;

% Condiciones iniciales del ejercicio 1
n = 100;
x = zeros(n, 1);
max = 1e-5;
iteraciones = 1000;
ek = 0;
k = 0;

% matriz A
diagonal_principal = (4 * ones(n, 1));
diagonal_externa = (-1 * ones(n-1, 1));

% A con diagonal principal
A = diag(diagonal_principal);


% Sumamos las diagonales_externas
A = A + diag(diagonal_externa, 1);
A = A +diag(diagonal_externa, -1);

% Vector b
b = (1:n)';

% ciclo
while (ek < max && k < iteraciones)
  bk = b + 0.2 * x;
  x_nuevo = A \ bk;

  % calculo del ek
  ek = norm(x_nuevo - x, 2);

  x = x_nuevo;
  k = k + 1;
endwhile


disp('---Numero de iteraciones realizadas---')
k

disp('---Valor final de ek---')
ek

disp('---Primeros cinco componentes---')
disp(x(1:5))

disp('---Ultimos cinco componentes---')
disp(x(end-4:end))


