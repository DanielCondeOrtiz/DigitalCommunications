function [An] = detecta(Zn, alfabeto)

% Zn       = una secuencia de símbolos más ruido
% alfabeto = tabla con los símbolos  
% 
% Genera:
%
% An = una secuencia de símbolos pertenecientes al alfabeto de acuerdo  con
% una regla de decisión euclidiana (mínima distancia)

% Longitud de la secuencia 
N=length(Zn);

An=zeros(1,N);

for i=1:N
    [~, ind]=min(abs(Zn(i)-alfabeto));
    An(i)=alfabeto(ind);
end