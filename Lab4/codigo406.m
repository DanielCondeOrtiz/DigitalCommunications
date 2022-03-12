% Par�metros suministrados:

% Bn = Secuencia de d�gitos binarios
% Eb = Energia media transmitida en Julios
% Rb = Tasa de bit de la se�al
% L = n�mero de puntos que vamos a utilizar para transmitir un s�mbolo
% M = n�mero de s�mbolos
clear all
close all

% Datos
Bn=[0,0,0,0,0,1,0,1,1,0,1,0,1,1,0,1,1,1,1,0,1,1,0,0];
Eb=4;
L=8;
Rb=10^(3);
M=8;

% Definici�n de los pulsos b�sicos
s1 = [ones(1,L/2), zeros(1,L/2)]; 
s2 = [zeros(1,L/2), ones(1,L/2)]; 

[Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1,s2,L);

% Obtengamos los par�metros necesarios para la representaci�n tras las posibles modificaciones
L=length(phi1);	%N�mero de muestras por s�mbolo
Nb=length(Bn)	;	%N�mero de bits transmitidos
M=length(alfabeto);		%N�mero de s�mbolos de la constelaci�n

% Definamos los par�metros del tiempo continuo para representar
Tb=1/Rb;            % Duraci�n del bit en segundos
Tm=(Tb*log2(M))/L;  % Intervalo entre cada muestra de la se�al
Td = Tb*Nb;         % Duraci�n total de la se�al
t = 0:Tm:Td-Tm;     % Eje de representaci�n de la se�al en tiempo continuo

Xt = sqrt (1/Tm )*Xn;
figure(1) ;
stem(Xn);
figure(2) 
h=plot(t,Xt); 
set(h,'linewidth', 1.0);
grid on
xlabel('t[s]'); ylabel('X(t)');
