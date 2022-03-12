function [An] = detectaSBF(rn,alfabeto)
% function [An] = detectaSBF(rn,alfabeto)
%
% rn       = una secuencia de s�mbolos m�s ruido
% alfabeto = tabla con los niveles de amplitud/s�mbolos  
% 
% Genera:
% An = una secuencia de s�mbolos pertenecientes al alfabeto de acuerdo con
% una regla de distancia euclidiana m�nima (m�nima distancia)

% Genera una repetici�n del alfabeto
alfabeto_repetido=repmat(alfabeto',1,length(rn));

% Genera una repetici�n de la secuencia del vector de observaci�n
rn_repetido=repmat(rn,length(alfabeto),1);

% Obtiene el �ndice respecto al alfabeto
[~,ind]=min(abs(rn_repetido-alfabeto_repetido));

% Genera la secuencia de niveles detectados
An=alfabeto(ind);
