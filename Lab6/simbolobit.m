function [Bn] = simbolobit(An,alfabeto)

% An       = secuencia de símbolos pertenecientes al alfabeto
% alfabeto = tabla con los símbolos utilizados en la transmisión 
% Bn       = una secuencia de bit, considerando que los símbolos se habían
% generado siguiendo una codificación de Gray

% ¿Cuántos bits hay en cada símbolo?
k=log2(length(alfabeto));

if k>1
    distancia = abs(alfabeto(1)-alfabeto(2));
    indices   = round((An-alfabeto(1))/distancia);
    Bn        = reshape(de2gray(indices,k)',1,k*length(An));
else
    Bn=((An/max(alfabeto))+1)/2;
end