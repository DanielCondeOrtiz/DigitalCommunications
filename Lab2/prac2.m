clear all
close all
%Generar Np muestras de una v.a. gausiana de media 0 y var 1
Np=1e6;
w=randn(1,Np);

%Var 4 y media 1
z=sqrt(4)*w +1;

%1
mn1=1;
mn2=-1;
vn1=4;
vn2=4;

n1=sqrt(vn1)*randn(1,Np) +mn1;
n2=sqrt(vn2)*randn(1,Np) +mn2;

%Fdp teorica: Gausianas(mn1,vn1),(mn2,vn2)
t=[-5:0.1:5];
fn1t=LCDnormal(t,mn1,vn1);
fn2t=LCDnormal(t,mn2,vn2);
figure
subplot(2,1,1);
plot(t,fn1t,'k')
hold on
subplot(2,1,1);
plot(n1(1:100),zeros(1,100),'r*')
subplot(2,1,2);
plot(t,fn2t,'k')
hold on
subplot(2,1,2);
plot(n2(1:100),zeros(1,100),'r*')

%Calcular fdp de forma experimental
%Como Np son intervalos muy pequeños:
Nbins=50;
[fn1e,xn1]=LCDfdp(n1,Nbins);
[fn2e,xn2]=LCDfdp(n2,Nbins);
subplot(2,1,1);
plot(xn1,fn1e,'go')
hold off
subplot(2,1,2);
plot(xn2,fn1e,'go')
hold off

x=n1+n2;
mx=mn1+mn2;
vx=vn1+vn2;
t=[-10:0.1:10];
fxt=LCDnormal(t,mx,vx);
figure
plot(t,fxt,'k');
hold on

[fxe,xe]=LCDfdp(x,Nbins);
plot(xe,fxe,'go')
hold off

close all


%3
%fdm de A
A=sign(randi([0,3],1,Np)-2.5);
[fa,ca]=LCDfmp(A);
figure
stem(ca,fa,'filled');
hold on

%b
vn=0.1;
n=sqrt(vn)*randn(1,Np);

y1=1+n;

%fdp teorica
my=0+1; %media ruido=0 y se desplaza 1
vy=0.1;

Nbins=50;
t=[-5:0.1:5];
fy1t=LCDnormal(t,my,vy);
[fy1e,cy1]=LCDfdp(y1,Nbins);
plot(t,fy1t,'k',cy1,fy1e,'ko');

%c
y2=-1+n;

%fdp teorica
my=-1; %media ruido=0 y se desplaza 1
vy=0.1;

Nbins=50;
t=[-5:0.1:5];
fy2t=LCDnormal(t,my,vy);
[fy2e,cy2]=LCDfdp(y2,Nbins);
plot(t,fy2t,'k',cy2,fy2e,'ko');


%d
y=n+A;
my=0;
vy=0.1;

close all

t=[-5:0.1:5];
fyt=3/4*fy2t+1/4*fy1t;
[fye,cy]=LCDfdp(y,Nbins);
plot(t,fyt,'k',cy,fye,'ko');



















