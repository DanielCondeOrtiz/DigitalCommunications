%1
clear all
close all
clc

Np=1e6;
x=sign(randi([0,3],1,Np)-2.5); %yo diria que es [0,3] y -2.5

[fx,cx]=LCDfmp(x);
stem(cx,fx)

close

%2
N1=2*rand(1,Np)-1;
%No lo piden pero bueno
pasox=0.01;
ejex=[-3.5:pasox:3.5];
[fn1,cn1]=LCDfdp(N1,ejex);
plot(cn1,fn1)

close
N2=2*rand(1,Np)-1;
N=N1+N2;

[fn,cn]=LCDfdp(N,ejex);
plot(ejex,fn)
%ejex=cx
close

%3
ym1=N-1;
[fym1,cym1]=LCDfdp(ym1,ejex);
plot(ejex,fym1,'r')
hold on

yM1=N+1;
[fyM1,cyM1]=LCDfdp(yM1,ejex);
plot(ejex,fyM1,'b')
hold off
close

%4
q=3/4;
p=1/4;
plot(ejex,fym1*q,'r',ejex,p*fyM1,'b')
close

%5
indiceumbral=find(p*fyM1>q*fym1,1);
umbral=ejex(indiceumbral)
%6
%resuelto analiticamente en el prob 2.21
%pe1=9/32;
%pem1=1/32;


%7
%pe=p*pe1+q*pem1;=3/32

%8
pe1=sum(fyM1(1:indiceumbral)*pasox)
pe1t=9/32
pe2=sum(fym1(indiceumbral:end)*pasox)
pe2t=1/32

pe=p*pe1+q*pe2
pet=3/32

%Pe por Montecarlo, no lo piden pero lo ha explicado
Y=x+N;
Xe=sign(Y-umbral);
Pe=sum(x~=Xe)/Np

%ML
indiceumbralml=find(fyM1>fym1,1);
umbralml=ejex(indiceumbralml)
Xeml=sign(Y-umbralml);
Peml=sum(x~=Xeml)/Np


