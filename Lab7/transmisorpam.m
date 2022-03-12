
function [Xn,Bn,An,phi,alfabetopam] = transmisorpam(Bn,Eb,M,s, L)
%
% [Xn,Bn,An, phi,alfabetopam] = transmisorpam(Bn,M,Eb,s,L)
% 
% Bn = Secuencia de dígitos binarios
% Eb = Energía media por bit transmitida en Julios
% M  = Número de símbolos del código PAM
% s  = Pulso básico 
% L  = Número de puntos que vamos a utilizar en la representación de un
% símbolo
%
% Devuelve:
% Xn = la señal de información (discreta)
% Bn = La secuencia de dígitos binarios realmente transmitidos
% An = La secuencia de niveles de amplitud transmitidos
% phi = Pulso básico real normalizado de energía unidad
% alfabetopam = Los niveles de amplitud asociados a cada símbolo transmitido

% Obtengamos en primer lugar los niveles asociado a cada símbolo
% ¿cuántos bits hay en cada símbolo?
k=ceil(log2(M));

% Ajustemos M a una potencia de dos
M=2^(k);

% El alfabeto [Ver la ecuación (4.10)] 
alfabetopam=sqrt(3*Eb*log2(M)/(M^2-1))*(2*(1:1:M)-M-1);

% Si la secuencia Bn no tiene una longitud múltiplo de k, se completa con ceros
Nb=length(Bn);  % Número de bits que vamos a transmitir
Bn=[Bn, zeros(1,k*ceil(Nb/k)-Nb)];
Nb=length(Bn);  % Número de bits que vamos a transmitir tras la corrección
Ns=Nb/k;        % Número de símbolos que vamos a transmitir

% La secuencia generada
if M>2
    An=alfabetopam(gray2de(reshape(Bn,k,Nb/k)')+1);
else
    An=alfabetopam(Bn+1);
end

% Comprobación de las longitudes y otros datos del pulso básico para hacer
% que el número de muestras del mismo sea efectivamente L
Ls=length(s);
if Ls<=L
    s=[s,zeros(1,L-Ls)];
else
    disp(['La duración del pulso se ha truncado a ',num2str(L), 'muestras'])
    s=s(1:L);
end

% Normalicemos la energía del pulso suministrado para obtener la base del sistema
phi=(1/sqrt(s*s'))*s;   

% Obtención del tren de pulsos
Xn=kron(An,phi);

end




