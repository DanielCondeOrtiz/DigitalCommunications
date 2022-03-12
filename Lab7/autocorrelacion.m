function [Rx,tau,maxlag] = autocorrelacion(Eb,M,p, L,Tb,Nb)
%
% [Rx,tau,maxlag] = autocorrelacion(Bn,M,Eb,s,L,Tb)
% 
% Bn = Secuencia de d�gitos binarios
% Eb = Energ�a media por bit transmitida en Julios
% M  = N�mero de s�mbolos del c�digo PAM
% p  = Pulso b�sico 
% L  = N�mero de puntos que vamos a utilizar en la representaci�n de un
% s�mbolo
% Tb = Duraci�n del bit en segundo
% Nb = N�mero de bits que vamos a utilizar en la simulaci�n
%
% Devuelve:
% Rx = El promedio temporal de la funci�n autocorrelaci�n
% tau = Un vector de tiempo para su representaci�n
% maxlag =[-maxlag,maxlag] es el intervalo de c�lculo de la autocorrelaci�n

% Obtengamos la se�al transmitida
[Xn,Bn,~,phi,~]=transmisorpam(randi(2,1,Nb)-1,Eb,M,p,L);
Nb=length(Bn);
L=length(phi);

% Vamos a realizar el c�lculo de la autocorrelaci�n entre -maxlag y maxlag
maxlag = 1024;   
Rx=xcorroctave(Xn,maxlag)/(Nb*Tb);
%Rx=xcorroctave(Xn,maxlag)/(Nb*Tb);

% Periodo de muestreo utilizado
Tm = (Tb*log2(M))/L;

tau = linspace(-maxlag*Tm,maxlag*Tm,2*maxlag+1); % El eje t escalado en sg
end

% % Calculemos la autocorrelaci�n de la se�al transmitida NumVeces
% R=zeros(1,2*maxlag+1);  % Valor inicial del vector autocorrelaci�n
% NumVeces=100;
% for i=1:NumVeces
% 	[Xn,~,~,~]=transmisorpam(randi(2,1,Nb)-1, Eb, M,s,L);
% 	temp=xcorr(Xn,maxlag)/(Nb*Tb);
% 	R = R + temp;
% end
% % El promedio de las autocorrelaciones calculadas
% Rx = R/NumVeces;
