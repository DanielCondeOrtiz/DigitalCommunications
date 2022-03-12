% Par�metros suministrados:

% Bn = Secuencia de d�gitos binarios
% Eb = Energia media transmitida en Julios
% Rb = Tasa de bit de la se�al
% L = n�mero de puntos que vamos a utilizar para transmitir un s�mbolo
% M1 = N� de s�mbolos de la componente en fase
% M2 = N� de s�mbolos de la componente en cuadratura

clear all
close all

% Datos
Bn=randi(2,1,64)-1;
Eb=4;
L=50;
Rb=10^(3);
M1=2;
M2=2;

% Definici�n de los pulsos b�sicos
s1=cos(8*pi/L*[1:L]);
s2=sin(8*pi/L*[1:L]);

[Xn,BnI,BnQ, AI,AQ,phi1,phi2]=transmisorqam(Bn, Eb, M1, M2,s1,s2,L);

% Obtengamos los par�metros necesarios para la representaci�n tras las posibles modificaciones
L=length(phi1);                 	%N�mero de muestras por s�mbolo
Nb=length(BnI)+length(BnQ);		%N�mero de bits transmitidos
M=length(AI)*length(AQ);					%N�mero de s�mbolos de la constelaci�n
% Definamos los par�metros del tiempo continuo para representar
Tb=1/Rb;                % Duraci�n del bit en segundos
Tm=(Tb*log2(M))/L;      % Intervalo entre cada muestra de la se�al
Td = Tb*Nb;             % Duraci�n de la se�al
t = 0:Tm:Td-Tm;         % Eje de representaci�n de la se�al en tiempo continuo

Xt = sqrt (1/Tm )*Xn;
figure(1) ;
stem(Xn);
figure(2) 
h=plot(t,Xt); 
set(h,'linewidth', 1.0);
grid on
xlabel('t[s]'); ylabel('X(t)');
