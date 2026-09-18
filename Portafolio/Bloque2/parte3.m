clc;
clear;
close all;

% Cargar las funciones implementadas en la Parte I.
source('parte1.m');


% ---------------------------------------------------------------------
% 1. DATOS DEL PROBLEMA Y MALLA DE DIFERENCIAS FINITAS
% ---------------------------------------------------------------------
L = 1;                    % Longitud de la barra en metros
numPuntos = 501;          % Puntos x_0, x_1, ..., x_500
h = L/(numPuntos-1);      % h = 1/500

x = (0:h:L)';             % Vector con los 501 puntos de la barra
xInterior = x(2:end-1);   % x_1, x_2, ..., x_499
n = length(xInterior);    % Numero de incognitas: 499

Tizquierda = 20;          % T(0) = 20 grados Celsius
Tderecha = 50;            % T(1) = 50 grados Celsius

% ---------------------------------------------------------------------
% 2. CONSTRUCCION DEL SISTEMA A*T=b
% ---------------------------------------------------------------------
% Para cada punto interior se utiliza la aproximacion centrada
%
%   -T''(x_i) aproximadamente
%   (-T_{i-1}+2*T_i-T_{i+1})/h^2.
%
% Como 1/h^2 = 250000, los coeficientes del sistema son:
%   diagonal principal: 2/h^2 + 10^4 = 510000
%   diagonales vecinas: -1/h^2 = -250000

coefVecino = -1/(h^2);
coefDiagonal = 2/(h^2)+10^4;

A = coefDiagonal*eye(n) ...
    +coefVecino*diag(ones(n-1,1),1) ...
    +coefVecino*diag(ones(n-1,1),-1);

% Termino independiente evaluado en los puntos interiores.
g = 300000*xInterior ...
    +(100000+10*pi^2)*sin(pi*xInterior) ...
    +200000;

b = g;

% Incorporar las condiciones de frontera en la primera y ultima ecuacion.
b(1) = b(1)+(1/h^2)*Tizquierda;   % 250000*20 = 5000000
b(n) = b(n)+(1/h^2)*Tderecha;     % 250000*50 = 12500000

% Parametros solicitados para los metodos iterativos.
Tinicial = zeros(n,1);
iterMax = 10000;
tol = 1e-8;


% ---------------------------------------------------------------------
% 3. ESTRUCTURAS PARA ALMACENAR LOS RESULTADOS
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

% Para los metodos directos, las iteraciones y conv no aplican.
iteraciones = NaN(1,numMetodos);
convergencias = NaN(1,numMetodos);


% ---------------------------------------------------------------------
% 4. EJECUCION DE LOS METODOS DIRECTOS
% ---------------------------------------------------------------------

% 4.1 Eliminacion Gaussiana
tic;
T_gauss = eliminacion_gaussiana(A,b);
tiempos(1) = toc;
errores(1) = norm(A*T_gauss-b,2);

% 4.2 Factorizacion LU
tic;
T_lu = factorizacion_LU(A,b);
tiempos(2) = toc;
errores(2) = norm(A*T_lu-b,2);

% 4.3 Factorizacion de Cholesky
tic;
T_cholesky = metodo_cholesky(A,b);
tiempos(3) = toc;
errores(3) = norm(A*T_cholesky-b,2);

% 4.4 Factorizacion QR
tic;
T_qr = metodo_QR(A,b);
tiempos(4) = toc;
errores(4) = norm(A*T_qr-b,2);

% 4.5 Metodo de Thomas
tic;
T_thomas = metodo_thomas(A,b);
tiempos(5) = toc;
errores(5) = norm(A*T_thomas-b,2);


% ---------------------------------------------------------------------
% 5. EJECUCION DE LOS METODOS ITERATIVOS
% ---------------------------------------------------------------------

% 5.1 Jacobi
tic;
[T_jacobi,erk_jacobi,k_jacobi,conv_jacobi] = ...
  metodo_Jacobi(A,b,Tinicial,tol,iterMax);
tiempos(6) = toc;
errores(6) = norm(A*T_jacobi-b,2);
iteraciones(6) = k_jacobi;
convergencias(6) = conv_jacobi;

% 5.2 Gauss-Seidel
tic;
[T_seidel,erk_seidel,k_seidel,conv_seidel] = ...
  metodo_Gauss_Seidel(A,b,Tinicial,tol,iterMax);
tiempos(7) = toc;
errores(7) = norm(A*T_seidel-b,2);
iteraciones(7) = k_seidel;
convergencias(7) = conv_seidel;

% 5.3 Gradiente Conjugado
tic;
[T_gradiente,erk_gradiente,k_gradiente,conv_gradiente] = ...
  gradiente_conjugado(A,b,Tinicial,tol,iterMax);
tiempos(8) = toc;
errores(8) = norm(A*T_gradiente-b,2);
iteraciones(8) = k_gradiente;
convergencias(8) = conv_gradiente;


% ---------------------------------------------------------------------
% 6. TABLA COMPARATIVA EN LA TERMINAL
% ---------------------------------------------------------------------
fprintf('\n');
fprintf('================================================================================\n');
fprintf('    DISTRIBUCION DE TEMPERATURA - SISTEMA DE TAMANO %d x %d\n',n,n);
fprintf('================================================================================\n');
fprintf('%-20s %15s %15s %13s %8s\n', ...
        'Metodo','Error','Tiempo (s)','Iteraciones','Conv');
fprintf('--------------------------------------------------------------------------------\n');

for i = 1:numMetodos
  if i <= 5
    fprintf('%-20s %15.6e %15.6e %13s %8s\n', ...
            metodos{i},errores(i),tiempos(i),'-','-');
  else
    fprintf('%-20s %15.6e %15.6e %13d %8d\n', ...
            metodos{i},errores(i),tiempos(i), ...
            iteraciones(i),convergencias(i));
  endif
endfor

fprintf('================================================================================\n');
fprintf('Tolerancia de los metodos iterativos: %.1e\n',tol);
fprintf('Numero maximo de iteraciones: %d\n',iterMax);


% ---------------------------------------------------------------------
% 7. GRAFICA COMPARATIVA DE LOS ERRORES
% ---------------------------------------------------------------------
% Los valores nulos no pueden mostrarse en escala logaritmica. Solo para
% la grafica se sustituyen por eps; la tabla mantiene los valores reales.
erroresGrafica = max(errores,eps);

figure(1);
bar(1:numMetodos,erroresGrafica);
set(gca,'yscale','log');
set(gca,'xtick',1:numMetodos);
set(gca,'xticklabel',metodos);
xtickangle(35);
grid on;
xlabel('Metodo numerico');
ylabel('Error ||A*T-b||_2 (escala logaritmica)');
title('Comparacion de errores en la distribucion de temperatura');


% ---------------------------------------------------------------------
% 8. GRAFICA COMPARATIVA DE LOS TIEMPOS
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
% 9. GRAFICA DE ITERACIONES DE LOS METODOS ITERATIVOS
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
title('Iteraciones de los metodos aplicados a la barra');


% ---------------------------------------------------------------------
% 10. DISTRIBUCION DE TEMPERATURA EN LA BARRA
% ---------------------------------------------------------------------
% Se utiliza Thomas como solucion numerica porque el sistema es
% tridiagonal y este metodo aprovecha directamente esa estructura.
T_numerica = [Tizquierda; T_thomas; Tderecha];

% La solucion exacta se usa unicamente para corroborar graficamente el
% comportamiento de la aproximacion, tal como solicita el enunciado.
xExacta = linspace(0,L,2000)';
T_exacta = 20+30*xExacta+10*sin(pi*xExacta);

figure(4);
plot(xExacta,T_exacta,'b-','linewidth',2);
hold on;
scatter(x,T_numerica,13,'r','filled');
hold off;
grid on;
xlabel('Posicion x a lo largo de la barra (m)');
ylabel('Temperatura T(x) (grados Celsius)');
title('Distribucion estacionaria de temperatura en la barra');
legend('Solucion exacta','Diferencias finitas - Thomas', ...
       'location','best');

drawnow;


% ---------------------------------------------------------------------
% 11. ANALISIS E INTERPRETACION EN LA TERMINAL
% ---------------------------------------------------------------------
[menorTiempo,indiceTiempo] = min(tiempos);
[menorError,indiceError] = min(errores);

fprintf('\n');
fprintf('========================= ANALISIS DE RESULTADOS =========================\n');

fprintf(['La matriz obtenida es tridiagonal, simetrica y positiva definida. ', ...
         'Tambien es estrictamente diagonal dominante, pues 510000 es ', ...
         'mayor que la suma 250000+250000 de los valores absolutos ', ...
         'fuera de la diagonal en las filas interiores. Por tanto, los ', ...
         'metodos seleccionados son adecuados para este sistema.\n\n']);

fprintf(['Los residuos de la tabla permiten evaluar directamente cuanto ', ...
         'satisface cada aproximacion el sistema A*T=b. Los residuos ', ...
         'pequenos muestran que las soluciones obtenidas son ', ...
         'numericamente equivalentes para el modelo discretizado, aunque ', ...
         'pueden existir diferencias debidas al redondeo y al criterio ', ...
         'de parada de los metodos iterativos.\n\n']);

fprintf(['El metodo de Thomas aprovecha la estructura tridiagonal: almacena ', ...
         'y procesa solamente las tres diagonales relevantes y su costo ', ...
         'crece de forma aproximadamente lineal con el numero de ', ...
         'incognitas. Los metodos generales trabajan con la matriz ', ...
         'completa y realizan mas operaciones sobre elementos nulos.\n\n']);

fprintf(['Cholesky resulta apropiado porque A es simetrica y positiva ', ...
         'definida. Su factorizacion A=L*L'' requiere menos operaciones ', ...
         'y almacenamiento que una factorizacion general cuando se ', ...
         'aprovechan esas propiedades.\n\n']);

fprintf(['Jacobi calcula cada componente utilizando la iteracion anterior. ', ...
         'Gauss-Seidel reutiliza inmediatamente los valores actualizados, ', ...
         'por lo que normalmente necesita menos iteraciones para esta ', ...
         'matriz diagonalmente dominante. La tabla permite comprobar ', ...
         'esta diferencia en la ejecucion actual.\n\n']);

fprintf(['Gradiente Conjugado tambien es adecuado por la simetria y ', ...
         'definicion positiva de A. Sus direcciones A-conjugadas pueden ', ...
         'reducir el numero de iteraciones respecto de los metodos ', ...
         'estacionarios.\n\n']);

fprintf('En esta ejecucion, el menor tiempo fue obtenido por %s: %.6e s.\n', ...
        metodos{indiceTiempo},menorTiempo);
fprintf('El menor residuo fue obtenido por %s: %.6e.\n\n', ...
        metodos{indiceError},menorError);

fprintf('Resultados de los metodos iterativos:\n');
fprintf('  Jacobi:             k = %d, conv = %d, error = %.6e\n', ...
        k_jacobi,conv_jacobi,errores(6));
fprintf('  Gauss-Seidel:       k = %d, conv = %d, error = %.6e\n', ...
        k_seidel,conv_seidel,errores(7));
fprintf('  Grad. Conjugado:    k = %d, conv = %d, error = %.6e\n\n', ...
        k_gradiente,conv_gradiente,errores(8));

fprintf(['En la figura de temperatura, los puntos producidos por ', ...
         'diferencias finitas siguen la curva exacta. Esto corrobora ', ...
         'graficamente que la discretizacion representa adecuadamente ', ...
         'la distribucion estacionaria a lo largo de la barra.\n\n']);

fprintf('====================== INTERPRETACION FISICA ======================\n');
fprintf(['La temperatura parte de 20 grados Celsius en x=0 y alcanza ', ...
         '50 grados Celsius en x=1. La fuente de calor distribuida ', ...
         'produce una curva no lineal entre ambos extremos. Cada valor ', ...
         'T_i representa la temperatura estacionaria aproximada de la ', ...
         'barra en la posicion x_i=i/500 metros.\n']);
fprintf('===================================================================\n');
