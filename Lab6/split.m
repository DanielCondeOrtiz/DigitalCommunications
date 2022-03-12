function [BnI,BnQ]=split(Bn, M1, M2)

% Bn = una secuencia de simbolos binarios
% M1 = n� de s�mbolos de la componente en fase
% M2 = n� de s�mbolos de la componente en cuadratura

% BnI = La secuencia de s�mbolos binarios de la componente en fase
% BnQ = La secuencia de s�mbolos binarios de la componente en cuadratura

k1=log2(M1);
k2=log2(M2);
k=k1+k2;

% Longitud de la secuencia
Nb=length(Bn);

% Una matriz con Nb/k filas formadas por los k1 bits m�s los k2 bits
W=reshape(Bn',k,Nb/k)'; 

% Extrae la submatriz formada por los k1 primeros bits y pone una fila tras otra
BnI=reshape(W(:,1:k1)',k1*Nb/k,1)';

% Extrae la submatriz formada por los k2 bits restantes y pone una fila tras otra
BnQ=reshape(W(:,k1+1:end)',k2*Nb/k,1)';
