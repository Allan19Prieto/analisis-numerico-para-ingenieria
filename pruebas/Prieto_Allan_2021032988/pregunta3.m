
clc; clear;
pkg load symbolic

g='x**4-6*x**2+2*x+1';

gn = str2func(['@(x)' g]);
gs=sym(g);

x = linspace(-3, 3, 100);
y = gs;

plot(x, gn);

