function [Xn, BnI, BnQ, AI, AQ, phi1,phi2] = transmisorqam(Bn, Eb, M1, M2, s1,s2, L)

% [Xn, BnI, BnQ, AI, AQ, phi1,phi2] = transmisorqam(Bn, Eb, M1, M2, s1,s2, L)
%
% Bn = Secuencia de d�gitos binarios
% Eb = Energ�a media transmitida en Julios
% M1 = N� de s�mbolos de la componente en fase
% M2 = N� de s�mbolos de la componente en cuadratura
% s1 = Pulso b�sico para transmitir los s�mbolos en fase
% s2 = Pulso b�sico para transmitir los s�mbolos en cuadratura
% L  = N� de puntos que vamos a utilizar en la representaci�n un s�mbolo
%
% Devuelve:
% Xn  = la se�al de informaci�n digital 
% BnI = Bits transmitidos por la componente en fase
% BnQ = Bits transmitidos por la componente en cuadratura
% AI  = Niveles de amplitud usados en la componente en fase 
% AQ  = Niveles de amplitud usados en la componente en cuadratura
% phi1  = Pulso b�sico normalizado usado en la componente en fase 
% phi2  = Pulso b�sico normalizado usado en la componente en cuadratura

% Ajustemos los par�metros
k1=ceil(log2(M1));  % N�mero de bits de la componente en fase
M1=2^(k1);          % Valor de M1 tras la correcci�n
k2=ceil(log2(M2));  % N�mero de bist de la componente en cuadratura
M2=2^(k2);          % Valor de M2 tras la correcci�n

k=k1+k2;            % N�mero de bits en cada s�mbolo QAM
Nb=length(Bn);  
Bn=[Bn, zeros(1,k*ceil(Nb/k)-Nb)];
L = ceil(L/2)*2;    % Forcemos que el n� de muestras por bit sea par

% Comprobaci�n de las longitudes y otros datos de los pulsos b�sicos
Ns1=length(s1);
Ns2=length(s2);

if Ns1==0 || Ns2==0
    disp('No es posible realizar la transmisi�n')
    return
end

if Ns1<L
    s1=[s1,zeros(1,L-Ns1)];
else
    s1=s1(1:L);
end

if Ns2<L
    s2=[s2,zeros(1,L-Ns2)];
else
    s2=s2(1:L);
end

% Normalicemos las energ�as de los pulsos
phi1=(1/sqrt(s1*s1'))*s1;   
phi2=(1/sqrt(s2*s2'))*s2;   

% Comprobemos la ortogonalidad
if abs(phi1*phi2')>=1e0*eps
    disp('No es posible realizar la transmisi�n')
    return
end

% Obtengamos los niveles de amplitud de las componentes en fase y cuadratura que garantizan la energ�a por bit deseada
A= sqrt(3*Eb*log2(M1*M2)/(M1^2+M2^2-2));

% El alfabeto con los niveles
AI=A*(2*(1:1:M1)-M1-1);
AQ=A*(2*(1:1:M2)-M2-1);

% Dividamos la secuencia en las componentes en 
[BnI,BnQ]=split(Bn,M1,M2);
NbI=length(BnI);
NbQ=length(BnQ);

% Obtengamos la secuencia de s�mbolos 
if M1>2
    AnI=AI(gray2de(reshape(BnI,k1,NbI/k1)')+1);
else
    AnI=AI(BnI+1);
end

if M2>2
    AnQ=AQ(gray2de(reshape(BnQ,k2,NbQ/k2)')+1);
else
    AnQ=AQ(BnQ+1);
end

% Las componentes en fase, cuadratura y total
XnI=kron(AnI,phi1);
XnQ=kron(AnQ,phi2);

Xn=XnI+XnQ;
end
