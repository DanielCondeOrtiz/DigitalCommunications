
function [Xn,Bn,An,phi,alfabetopam] = transmisorpam(Bn,Eb,M,s, L)
%
% [Xn,Bn,An, phi,alfabetopam] = transmisorpam(Bn,M,Eb,s,L)
% 
% Bn = Secuencia de d�gitos binarios
% Eb = Energ�a media por bit transmitida en Julios
% M  = N�mero de s�mbolos del c�digo PAM
% s  = Pulso b�sico 
% L  = N�mero de puntos que vamos a utilizar en la representaci�n de un
% s�mbolo
%
% Devuelve:
% Xn = la se�al de informaci�n (discreta)
% Bn = La secuencia de d�gitos binarios realmente transmitidos
% An = La secuencia de niveles de amplitud transmitidos
% phi = Pulso b�sico real normalizado de energ�a unidad
% alfabetopam = Los niveles de amplitud asociados a cada s�mbolo transmitido

% Obtengamos en primer lugar los niveles asociado a cada s�mbolo
% �cu�ntos bits hay en cada s�mbolo?
k=ceil(log2(M));

% Ajustemos M a una potencia de dos
M=2^(k);

% El alfabeto [Ver la ecuaci�n (4.10)] 
alfabetopam=sqrt(3*Eb*log2(M)/(M^2-1))*(2*(1:1:M)-M-1);

% Si la secuencia Bn no tiene una longitud m�ltiplo de k, se completa con ceros
Nb=length(Bn);  % N�mero de bits que vamos a transmitir
Bn=[Bn, zeros(1,k*ceil(Nb/k)-Nb)];
Nb=length(Bn);  % N�mero de bits que vamos a transmitir tras la correcci�n
Ns=Nb/k;        % N�mero de s�mbolos que vamos a transmitir

% La secuencia generada
if M>2
    An=alfabetopam(gray2de(reshape(Bn,k,Nb/k)')+1);
else
    An=alfabetopam(Bn+1);
end

% Comprobaci�n de las longitudes y otros datos del pulso b�sico para hacer
% que el n�mero de muestras del mismo sea efectivamente L
Ls=length(s);
if Ls<=L
    s=[s,zeros(1,L-Ls)];
else
    disp(['La duraci�n del pulso se ha truncado a ',num2str(L), 'muestras'])
    s=s(1:L);
end

% Normalicemos la energ�a del pulso suministrado para obtener la base del sistema
phi=(1/sqrt(s*s'))*s;   

% Obtenci�n del tren de pulsos
Xn=kron(An,phi);

end




