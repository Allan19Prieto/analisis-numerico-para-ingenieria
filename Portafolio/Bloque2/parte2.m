
% PORTAFOLIO COMPUTACIONAL - BLOQUE 2
% PARTE II: COMPARACION COMPUTACIONAL DE LOS METODOS
%

clc;
clear;
close all;

% Cargar las funciones implementadas en la Parte I.
% parte1.m debe encontrarse en la misma carpeta que este archivo.
source('parte1.m');


% ---------------------------------------------------------------------
% 1. CONSTRUCCION DEL SISTEMA A*x=b
% ---------------------------------------------------------------------
n = 300;

% Matriz tridiagonal con 4 en la diagonal principal y -1 en las
% diagonales inmediatamente superior e inferior.
A = 4*eye(n) ...
    -diag(ones(n-1,1),1) ...
    -diag(ones(n-1,1),-1);

b = ones(n,1);

% Parametros para los metodos iterativos.
x0 = zeros(n,1);
iterMax = 10000;
tol = 1e-8;


% ---------------------------------------------------------------------
% 2. ESTRUCTURAS PARA ALMACENAR LOS RESULTADOS
% ---------------------------------------------------------------------
metodos = {'Elim. Gaussiana', ...
           'LU', ...
           'Cholesky', ...
           'QR', ...
           'Thomas', ...
           'Jacobi', ...
           'Gauss-Seidel', ...
           'Grad. Conjugado'};

numMetodos = length(metodos);
errores = zeros(1,numMetodos);
tiempos = zeros(1,numMetodos);

% Para los metodos directos las iteraciones y la convergencia no aplican.
iteraciones = NaN(1,numMetodos);
convergencias = NaN(1,numMetodos);


% ---------------------------------------------------------------------
% 3. EJECUCION DE LOS METODOS DIRECTOS
% ---------------------------------------------------------------------

% 3.1 Eliminacion Gaussiana
tic;
x_gauss = eliminacion_gaussiana(A,b);
tiempos(1) = toc;
errores(1) = norm(A*x_gauss-b,2);

% 3.2 Factorizacion LU
tic;
x_lu = factorizacion_LU(A,b);
tiempos(2) = toc;
errores(2) = norm(A*x_lu-b,2);

% 3.3 Factorizacion de Cholesky
tic;
x_cholesky = metodo_cholesky(A,b);
tiempos(3) = toc;
errores(3) = norm(A*x_cholesky-b,2);

% 3.4 Factorizacion QR
tic;
x_qr = metodo_QR(A,b);
tiempos(4) = toc;
errores(4) = norm(A*x_qr-b,2);

% 3.5 Metodo de Thomas
tic;
x_thomas = metodo_thomas(A,b);
tiempos(5) = toc;
errores(5) = norm(A*x_thomas-b,2);


% ---------------------------------------------------------------------
% 4. EJECUCION DE LOS METODOS ITERATIVOS
% ---------------------------------------------------------------------

% 4.1 Jacobi
tic;
[x_jacobi,erk_jacobi,k_jacobi,conv_jacobi] = ...
  metodo_Jacobi(A,b,x0,tol,iterMax);
tiempos(6) = toc;
errores(6) = norm(A*x_jacobi-b,2);
iteraciones(6) = k_jacobi;
convergencias(6) = conv_jacobi;

% 4.2 Gauss-Seidel
tic;
[x_seidel,erk_seidel,k_seidel,conv_seidel] = ...
  metodo_Gauss_Seidel(A,b,x0,tol,iterMax);
tiempos(7) = toc;
errores(7) = norm(A*x_seidel-b,2);
iteraciones(7) = k_seidel;
convergencias(7) = conv_seidel;

% 4.3 Gradiente Conjugado
tic;
[x_gradiente,erk_gradiente,k_gradiente,conv_gradiente] = ...
  gradiente_conjugado(A,b,x0,tol,iterMax);
tiempos(8) = toc;
errores(8) = norm(A*x_gradiente-b,2);
iteraciones(8) = k_gradiente;
convergencias(8) = conv_gradiente;


% ---------------------------------------------------------------------
% 5. TABLA COMPARATIVA EN LA TERMINAL
% ---------------------------------------------------------------------
fprintf('\n');
fprintf('==========================================================================\n');
fprintf('       COMPARACION DE METODOS PARA EL SISTEMA DE TAMANO %d x %d\n',n,n);
fprintf('==========================================================================\n');
fprintf('%-20s %14s %14s %12s %8s\n', ...
        'Metodo','Error','Tiempo (s)','Iteraciones','Conv');
fprintf('--------------------------------------------------------------------------\n');

for i = 1:numMetodos
  if i <= 5
    fprintf('%-20s %14.6e %14.6e %12s %8s\n', ...
            metodos{i},errores(i),tiempos(i),'-','-');
  else
    fprintf('%-20s %14.6e %14.6e %12d %8d\n', ...
            metodos{i},errores(i),tiempos(i), ...
            iteraciones(i),convergencias(i));
  endif
endfor

fprintf('==========================================================================\n');
fprintf('Tolerancia utilizada en los metodos iterativos: %.1e\n',tol);
fprintf('Numero maximo de iteraciones: %d\n',iterMax);


% ---------------------------------------------------------------------
% 6. GRAFICA COMPARATIVA DE LOS ERRORES
% ---------------------------------------------------------------------
% Un valor exactamente igual a cero no puede representarse en escala
% logaritmica. Solo para la grafica se sustituye por eps; la tabla conserva
% el valor calculado originalmente.
erroresGrafica = max(errores,eps);

figure(1);
bar(1:numMetodos,erroresGrafica);
set(gca,'yscale','log');
set(gca,'xtick',1:numMetodos);
set(gca,'xticklabel',metodos);
xtickangle(35);
grid on;
xlabel('Metodo numerico');
ylabel('Error ||A*x-b||_2 (escala logaritmica)');
title('Comparacion de errores de los metodos');


% ---------------------------------------------------------------------
% 7. GRAFICA COMPARATIVA DE LOS TIEMPOS
% ---------------------------------------------------------------------
tiemposGrafica = max(tiempos,realmin);

figure(2);
bar(1:numMetodos,tiemposGrafica);
set(gca,'yscale','log');
set(gca,'xtick',1:numMetodos);
set(gca,'xticklabel',metodos);
xtickangle(35);
grid on;
xlabel('Metodo numerico');
ylabel('Tiempo de ejecucion en segundos (escala logaritmica)');
title('Comparacion de tiempos de ejecucion');


% ---------------------------------------------------------------------
% 8. GRAFICA DE ITERACIONES DE LOS METODOS ITERATIVOS
% ---------------------------------------------------------------------
metodosIterativos = {'Jacobi','Gauss-Seidel','Grad. Conjugado'};
iteracionesIterativos = iteraciones(6:8);

figure(3);
bar(1:3,iteracionesIterativos);
set(gca,'xtick',1:3);
set(gca,'xticklabel',metodosIterativos);
grid on;
xlabel('Metodo iterativo');
ylabel('Numero de iteraciones');
title('Iteraciones requeridas por los metodos iterativos');

drawnow;


% ---------------------------------------------------------------------
% 9. ANALISIS COMPARATIVO EN LA TERMINAL
% ---------------------------------------------------------------------
[menorTiempo,indiceTiempo] = min(tiempos);
[menorError,indiceError] = min(errores);

fprintf('\n');
fprintf('====================== ANALISIS COMPARATIVO ======================\n');

fprintf(['La matriz A es tridiagonal, simetrica, estrictamente diagonal ', ...
         'dominante y positiva definida. Estas propiedades explican por ', ...
         'que todos los metodos utilizados son aplicables al sistema.\n\n']);

fprintf(['El metodo de Thomas aprovecha directamente la estructura ', ...
         'tridiagonal y realiza una cantidad de operaciones proporcional ', ...
         'al tamano del sistema. En cambio, Eliminacion Gaussiana, LU y QR ', ...
         'se implementaron como metodos generales y no aprovechan por ', ...
         'completo los ceros de la matriz.\n\n']);

fprintf(['Cholesky utiliza la simetria y la definicion positiva de A. ', ...
         'Por esta razon requiere menos almacenamiento y operaciones que ', ...
         'una factorizacion general, aunque esta implementacion trabaja ', ...
         'con matrices densas.\n\n']);

fprintf(['QR suele requerir mas operaciones que LU o Cholesky, pero la ', ...
         'ortogonalidad de Q le proporciona buenas propiedades de ', ...
         'estabilidad numerica.\n\n']);

fprintf(['Jacobi calcula cada aproximacion usando solamente los valores ', ...
         'de la iteracion anterior. Gauss-Seidel utiliza inmediatamente ', ...
         'los valores nuevos y, para este sistema diagonalmente dominante, ', ...
         'normalmente alcanza la tolerancia en menos iteraciones.\n\n']);

fprintf(['Gradiente Conjugado es especialmente apropiado porque A es ', ...
         'simetrica y positiva definida. Sus direcciones conjugadas evitan ', ...
         'repetir el avance en direcciones ya exploradas y pueden producir ', ...
         'una convergencia rapida.\n\n']);

fprintf('En esta ejecucion, el menor tiempo fue obtenido por %s: %.6e s.\n', ...
        metodos{indiceTiempo},menorTiempo);
fprintf('El menor residuo fue obtenido por %s: %.6e.\n\n', ...
        metodos{indiceError},menorError);

fprintf('Resultados de convergencia de los metodos iterativos:\n');
fprintf('  Jacobi:             k = %d, conv = %d, error = %.6e\n', ...
        k_jacobi,conv_jacobi,errores(6));
fprintf('  Gauss-Seidel:       k = %d, conv = %d, error = %.6e\n', ...
        k_seidel,conv_seidel,errores(7));
fprintf('  Grad. Conjugado:    k = %d, conv = %d, error = %.6e\n', ...
        k_gradiente,conv_gradiente,errores(8));

fprintf(['\nLos tiempos dependen del equipo y pueden variar entre ', ...
         'ejecuciones. Los residuos permiten comprobar que las soluciones ', ...
         'obtenidas satisfacen numericamente el sistema A*x=b.\n']);
fprintf('==================================================================\n');
