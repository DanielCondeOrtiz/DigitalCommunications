function [Rx,tau,maxlag] = autocorrelacion(Eb,M,p, L,Tb,Nb)
%
% [Rx,tau,maxlag] = autocorrelacion(Bn,M,Eb,s,L,Tb)
% 
% Bn = Secuencia de dígitos binarios
% Eb = Energía media por bit transmitida en Julios
% M  = Número de símbolos del código PAM
% p  = Pulso básico 
% L  = Número de puntos que vamos a utilizar en la representación de un
% símbolo
% Tb = Duración del bit en segundo
% Nb = Número de bits que vamos a utilizar en la simulación
%
% Devuelve:
% Rx = El promedio temporal de la función autocorrelación
% tau = Un vector de tiempo para su representación
% maxlag =[-maxlag,maxlag] es el intervalo de cálculo de la autocorrelación

% Obtengamos la señal transmitida
[Xn,Bn,~,phi,~]=transmisorpam(randi(2,1,Nb)-1,Eb,M,p,L);
Nb=length(Bn);
L=length(phi);

% Vamos a realizar el cálculo de la autocorrelación entre -maxlag y maxlag
maxlag = 1024;   
Rx=xcorroctave(Xn,maxlag)/(Nb*Tb);
%Rx=xcorroctave(Xn,maxlag)/(Nb*Tb);

% Periodo de muestreo utilizado
Tm = (Tb*log2(M))/L;

tau = linspace(-maxlag*Tm,maxlag*Tm,2*maxlag+1); % El eje t escalado en sg
end

% % Calculemos la autocorrelación de la señal transmitida NumVeces
% R=zeros(1,2*maxlag+1);  % Valor inicial del vector autocorrelación
% NumVeces=100;
% for i=1:NumVeces
% 	[Xn,~,~,~]=transmisorpam(randi(2,1,Nb)-1, Eb, M,s,L);
% 	temp=xcorr(Xn,maxlag)/(Nb*Tb);
% 	R = R + temp;
% end
% % El promedio de las autocorrelaciones calculadas
% Rx = R/NumVeces;
