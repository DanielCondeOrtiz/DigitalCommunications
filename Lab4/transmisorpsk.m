function [Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1, s2, L)
%
% [Xn,Bn,phi1,phi2,alfabeto] = transmisorpsk(Bn,Eb,M,s1, s2, L)
% 
% Bn = Secuencia de dígitos binarios
% Eb = Energía media por bit transmitida en Julios
% M  = Número de símbolos del código PSK
% s1  = Pulso básico de la componente en fase 
% s2  = Pulso básico de la componente en cuadratura
% L  = Número de puntos que vamos a utilizar en la representación de un
% símbolo
%
% Devuelve:
% Xn = la señal de información discreta
% Bn = La secuencia de dígitos binarios realmente transmitidos
% phi1 = Pulso básico real normalizado de la componente en fase 
% phi2 = Pulso básico real normalizado de la componente en cuadratura
% alfabeto = El alfabeto utilizado asociado a cada símbolo transmitido

% Obtengamos en primer lugar los niveles asociado a cada símbolo
% ¿cuántos bits hay en cada símbolo?
k=ceil(log2(M));

% Ajustemos M a una potencia de dos
M=2^(k);

% El alfabeto [Ver la ecuación (4.5)] 
alfabeto=sqrt(Eb*k)*exp(1i*2*pi*(0:1:M-1)/M);

% Si la secuencia Bn no tiene una longitud múltiplo de k, se completa con
% ceros
Nb=length(Bn);  % Número de bits que vamos a transmitir
Bn=[Bn, zeros(1,k*ceil(Nb/k)-Nb)];
Nb=length(Bn);  % Número de bits que vamos a transmitir tras la corrección

% La secuencia generada
if M>2
    An=alfabeto(gray2de(reshape(Bn,k,Nb/k)')+1);
else
    An=alfabeto(Bn+1);
end

% Comprobación de las longitudes y otros datos de los pulsos básicos
% que el número de muestras del mismo sea efectivamente L
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

% Normalicemos las energías de los pulsos
phi1=(1/sqrt(s1*s1'))*s1;   
phi2=(1/sqrt(s2*s2'))*s2;   

% Comprobemos la ortogonalidad
if abs(phi1*phi2')>=1e0*eps
    disp('No es posible realizar la transmisión')
    return
end

% El pulso básico complejo
phi=phi1-1i*phi2;

% Obtención del tren de pulsos
Xn=real(kron(An,phi));

end
