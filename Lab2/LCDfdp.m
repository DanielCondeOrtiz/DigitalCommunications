function [fx,cx]=LCDfdp(x,Nbins)
%x=muestras
%Nbins = numero de intervalos
[Nx,cx]=hist(x,Nbins);
%Nx = numero de puntos en cada intervalo
%cx = centro de cada intervalo
fx=Nx/length(x)/(cx(2)-cx(1));