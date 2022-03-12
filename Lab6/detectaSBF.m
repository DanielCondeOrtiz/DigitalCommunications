function [An] = detectaSBF(rn,alfabeto)
% function [An] = detectaSBF(rn,alfabeto)
%
% rn       = una secuencia de símbolos más ruido
% alfabeto = tabla con los niveles de amplitud/símbolos  
% 
% Genera:
% An = una secuencia de símbolos pertenecientes al alfabeto de acuerdo con
% una regla de distancia euclidiana mínima (mínima distancia)

% Genera una repetición del alfabeto
alfabeto_repetido=repmat(alfabeto',1,length(rn));

% Genera una repetición de la secuencia del vector de observación
rn_repetido=repmat(rn,length(alfabeto),1);

% Obtiene el índice respecto al alfabeto
[~,ind]=min(abs(rn_repetido-alfabeto_repetido));

% Genera la secuencia de niveles detectados
An=alfabeto(ind);
