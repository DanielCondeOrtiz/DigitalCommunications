close all
clear all
clc

%Esquema en cuaderno

Nb=1e6;
M=8;
Eb=8;
L=32;
Rb=1e4;
Bn=randi(2,1,Nb)-1; %Secuencia de digitos
g=sin((pi/L).*[0:L-1]); %Pulso conformador
p=cos((8*pi/L).*[0:L-1]).*g; %Portadora * pulso conformador

[Xn,Bn,An,phi,alfabetopam] = transmisorpam(Bn,Eb,M,p, L);

Nb=length(Bn);
subplot(2,1,1)
tn=[0:10*L-1];
stem(tn,Xn(1:10*L))
hold on

Tb=1/Rb;                % Duración del bit en segundos
Tm=(Tb*log2(M))/L;      % Intervalo entre cada muestra de la señal
Td = Tb*Nb;             % Duración de la señal
t = 0:Tm:Td-Tm;         % Eje de representación de la señal en tiempo continuo

xt = sqrt (1/Tm )*Xn;
subplot(2,1,2)
plot(t(1:(10*L)),xt(1:(10*L))) %Continuo

hold off
close all

Exn=Xn*Xn' /Nb %Energia

Ns=length(An);
sn=phi*reshape(Xn,L,Ns); %Demodulador

hr=fliplr(phi); %6.
plot(hr)
close all

Ann=unique(sn); %7.
plot(Ann,zeros(1,length(Ann)),'*r')
close all

%8.
umbralesMAP=diff(Ann)/2+Ann(1:M-1)

%9.
clc
SNRdb=16;
SNR=10^(SNRdb/10); 
No=Eb/SNR;
varzn=No/2
zn=sqrt(varzn)*randn(size(sn));
rn=sn+zn;

Andetectado=detectaSBF(rn,alfabetopam);
Bndetectado=simbolobit(Andetectado,alfabetopam);

for k=1:length(SNRdb)
  [fr,xr]=LCDfdp(rn,50);
  subplot(3,3,k);
  plot(xr,fr);
 end








