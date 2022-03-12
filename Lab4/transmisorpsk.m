function [Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1, s2, L)
%
% [Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1, s2, L)
% 
% Bn = Secuencia de d�gitos binarios
% Eb = Energ�a media por bit transmitida en Julios
% M  = N�mero de s�mbolos del c�digo PSK
% s1  = Pulso b�sico de la componente en fase 
% s2  = Pulso b�sico de la componente en cuadratura
% L  = N�mero de puntos que vamos a utilizar en la representaci�n de un
% s�mbolo
%
% Devuelve:
% Xn = la se�al de informaci�n discreta
% Bn = La secuencia de d�gitos binarios realmente transmitidos
% phi1 = Pulso b�sico real normalizado de la componente en fase 
% phi2 = Pulso b�sico real normalizado de la componente en cuadratura
% alfabeto = El alfabeto utilizado asociado a cada s�mbolo transmitido

% Obtengamos en primer lugar los niveles asociado a cada s�mbolo
% �cu�ntos bits hay en cada s�mbolo?
k=ceil(log2(M));

% Ajustemos M a una potencia de dos
M=2^(k);

% El alfabeto [Ver la ecuaci�n (4.5)] 
alfabeto=sqrt(Eb*k)*exp(1i*2*pi*(0:1:M-1)/M);

% Si la secuencia Bn no tiene una longitud m�ltiplo de k, se completa con
% ceros
Nb=length(Bn);  % N�mero de bits que vamos a transmitir
Bn=[Bn, zeros(1,k*ceil(Nb/k)-Nb)];
Nb=length(Bn);  % N�mero de bits que vamos a transmitir tras la correcci�n

% La secuencia generada
if M>2
    An=alfabeto(gray2de(reshape(Bn,k,Nb/k)')+1);
else
    An=alfabeto(Bn+1);
end

% Comprobaci�n de las longitudes y otros datos de los pulsos b�sicos
% que el n�mero de muestras del mismo sea efectivamente L
Ls=length(s1);
if Ls<L
    s1=[s1,zeros(1,L-Ls)];
else
    s1=s1(1:L);
end

Ls=length(s2);
if Ls<L
    s2=[s2,zeros(1,L-Ls)];
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

% El pulso b�sico complejo
phi=phi1-1i*phi2;

% Obtenci�n del tren de pulsos
Xn=real(kron(An,phi));

end
