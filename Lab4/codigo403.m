clear all
close all

% Datos
Bn=[1,0,1,1,1,1,0,1,0,1,0,0,0,1,0];
Eb=8;
L=8;
Rb=10^(6);
M=8;

% Aunque no es necesario, forcemos que el n� de muestras por s�mbolo sea par
L = ceil(L/2)*2;

% Definici�n del pulso b�sico de Manchester
s = ones(1,L); % La funci�n evaluada en los puntos elegidos
s(L/2+1:end) = -1;

[Xn,Bn,s,alfabeto]=transmisorpam(Bn,Eb,M,s, L);

% Representaci�n en tiempo discreto
figure(1)
stem(Xn)
xlabel('n'); ylabel('X(n)');

% Definamos los par�metros del tiempo continuo
Tb=1/Rb;            % Duraci�n del bit en segundos
Tm=(Tb*log2(M))/L;  % Intervalo entre cada muestra de la se�al
Nb=length(Bn); 	    % N�mero de bits transmitidos
Td = Tb*Nb;         % Duraci�n de la se�al
t = 0:Tm:Td-Tm;     % Eje de representaci�n de la se�al en tiempo continuo

Xt = sqrt (1/Tm )*Xn;
figure(2) 
h=plot(t,Xt); 
set(h,'linewidth', 1.0);
xlabel('t[s]'); ylabel('X(t)');
