function [An] = detecta(Zn, alfabeto)

% Zn       = una secuencia de s�mbolos m�s ruido
% alfabeto = tabla con los s�mbolos  
% 
% Genera:
%
% An = una secuencia de s�mbolos pertenecientes al alfabeto de acuerdo  con
% una regla de decisi�n euclidiana (m�nima distancia)

% Longitud de la secuencia 
N=length(Zn);

An=zeros(1,N);

for i=1:N
    [~, ind]=min(abs(Zn(i)-alfabeto));
    An(i)=alfabeto(ind);
end