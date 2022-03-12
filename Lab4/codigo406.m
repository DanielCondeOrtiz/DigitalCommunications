% Parámetros suministrados:

% Bn = Secuencia de dígitos binarios
% Eb = Energia media transmitida en Julios
% Rb = Tasa de bit de la señal
% L = número de puntos que vamos a utilizar para transmitir un símbolo
% M = número de símbolos
clear all
close all

% Datos
Bn=[0,0,0,0,0,1,0,1,1,0,1,0,1,1,0,1,1,1,1,0,1,1,0,0];
Eb=4;
L=8;
Rb=10^(3);
M=8;

% Definición de los pulsos básicos
s1 = [ones(1,L/2), zeros(1,L/2)]; 
s2 = [zeros(1,L/2), ones(1,L/2)]; 

[Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1,s2,L);

% Obtengamos los parámetros necesarios para la representación tras las posibles modificaciones
L=length(phi1);	%Número de muestras por símbolo
Nb=length(Bn)	;	%Número de bits transmitidos
M=length(alfabeto);		%Número de símbolos de la constelación

% Definamos los parámetros del tiempo continuo para representar
Tb=1/Rb;            % Duración del bit en segundos
Tm=(Tb*log2(M))/L;  % Intervalo entre cada muestra de la señal
Td = Tb*Nb;         % Duración total de la señal
t = 0:Tm:Td-Tm;     % Eje de representación de la señal en tiempo continuo

Xt = sqrt (1/Tm )*Xn;
figure(1) ;
stem(Xn);
figure(2) 
h=plot(t,Xt); 
set(h,'linewidth', 1.0);
grid on
xlabel('t[s]'); ylabel('X(t)');
