L=8;
N=10;
Tb=1e-3;
sn=ones(1,L);
sn=sn/sqrt(sum(sn.*sn));
A=(randi([0,1],1,N)-0.5)*4;
tn=[0:L-1];
%figure(1)
subplot(2,2,1);
stem(tn,sn)

Tm=Tb/L;
st=sn/sqrt(Tm);
%figure(2)
tt=[0:L-1]*Tm;
subplot(2,2,2);
plot(tt,st)
%close all

xn=kron(A,sn);
%figure(3)
subplot(2,2,3);
stem([0:N*L-1],xn)

xt=kron(A,st);
%figure(4)
subplot(2,2,4);
plot([0:N*L-1]*Tm,xt)

close all

Exn=sum(xn.*xn); %=xn*xn'
Ext=sum(xt.*xt)*Tm;

Pxn=xn.*xn;
Pxt=xt.*xt;

%Punto 5
%
%
sn= sin(2*pi/(2*Tb)*[0:L-1]*Tm);   %Supuestamente lo demas es igual
sn=sn/sqrt(sum(sn.*sn));
tn=[0:L-1];
subplot(2,2,1);
stem(tn,sn)

st=sn/sqrt(Tm);
tt=[0:L-1]*Tm;
subplot(2,2,2);
plot(tt,st)

xn=kron(A,sn); %se puede usar porque el pulso no se extiende mas alla de Tb
subplot(2,2,3);
stem([0:N*L-1],xn)

xt=kron(A,st);
subplot(2,2,4);
plot([0:N*L-1]*Tm,xt)

%close all

Exn=sum(xn.*xn); %=xn*xn'
Ext=sum(xt.*xt)*Tm;

Pxn=xn.*xn;
Pxt=xt.*xt;