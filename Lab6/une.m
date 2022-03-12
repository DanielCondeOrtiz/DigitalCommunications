function [Cn]=une(Cic, Cis, M1, M2)

%Cic = una secuencia de s�mbolos binarios correspondientes a los bits en
%posici�n m�ltiplo de k1
%Cis = una secuencia de s�mbolos binarios correspondientes a los bits en
%posici�n m�ltiplo de ks
%M1 = n� de s�mbolos de la componente en fase
%M2 = n� de s�mbolos de la componente en cuadratura
%
%Devuelve
%
%Cn = Los bits entremezclados

k1=log2(M1);
k2=log2(M2);

N=length(Cic)/k1;

C1=reshape(Cic',k1,N)';
C2=reshape(Cis',k2,N)';

C=[C1,C2];

Cn = reshape(C',N*(k1+k2),1)';