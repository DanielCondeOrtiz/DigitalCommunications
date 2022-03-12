function [fx,cx]=LCDfdp(x)
%x=muestras
cx=unique(x);
[Nx,cx]=hist(x,cx);
%unique da el vector sin elementos repetidos
%Nx = numero de puntos en cada intervalo
%cx = centro de cada intervalo, no hace falta ponerlo la 2a vez
fx=Nx/length(x);