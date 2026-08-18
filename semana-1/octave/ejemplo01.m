% Script: ejemplo01.m
clc; clear;
A = rand(3);
b = [1; 2; 3];
x = A\\b;

disp('Solución x = ');
disp(x)
