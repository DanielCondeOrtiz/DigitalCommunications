clear all
close all

L=4;
Nb=1e6;
Eb=9;

Bn=randi(2,1,Nb)-1;

% definamos el pulso b�sico
p=ones(1,L);

codigocolor = [0  0  0;
                0  1  0; 
                0  0  1;
                1  0  0;
                1  0  1;
                0  1  1];
jj=0;

% Definamos la relaci�n se�al ruido en dB
for M=[2,4,8,16,32]
    jj=jj+1;
    [Xn,Bn,An,phi,alfabeto]=transmisorpam(Bn,Eb,M,p,L);

    Nb=length(Bn);		%N�mero de bits transmitidos
    Ns=length(An);      %N�mero de s�mbolos transmitidos

    % Demodulaci�n mediante correlador
    sn=phi*reshape(Xn,L,Ns);	%Salida del integrador

    SNRdb = 0:1:20;
    errorsimulados=zeros(size(SNRdb));
    errorsimuladob=zeros(size(SNRdb));

    for ii=1:length(SNRdb)
        SNR = 10^(SNRdb(ii)/10);
        varzn = Eb/(2*SNR);
    
        % El ruido a la entrada del detector
        zn = sqrt(varzn)*randn(size(sn));
    
        % Se�al de entrada al detector
        rn = sn + zn;

        % Los s�mbolos detectados
        Andetectado = detectaSBF(rn, alfabeto);
    
        % Los bits correspondientes
        Bndetectado = simbolobit(Andetectado, alfabeto);
    
        % Contemos los errores
        conterrors = Ns-sum(Andetectado==An);
        errorsimulados(ii)=conterrors/Ns;
        
        conterrorb = Nb-sum(Bndetectado==Bn);
        errorsimuladob(ii)=conterrorb/Nb;
    
    end    
    color=codigocolor(jj,1:end);

    % Representaci�n de la probabilidad de error de s�mbolo
    figure(1)
    semilogy(SNRdb,errorsimulados,'r*');
    hold on
    
    % Para la representaci�n del error te�rico
    SNRdb2 = 0:0.01:20;
    errorteorico=zeros(size(SNRdb2));

    for ii=1:length(SNRdb2),
        SNR = 10^(SNRdb2(ii)/10);% relaci�n se�al ruido
        errorteorico(ii)=(2*(M-1)/M)*...
            Qfunct(sqrt((6*log2(M)/(M^2-1))*SNR));...
        echo off;
    end

    semilogy(SNRdb2,errorteorico,'-k','Color',color, 'LineWidth', 1);
    axis([0,20,1e-7,1])
    xlabel('Relaci�n Se�al/Ruido E_b/N_0 (dB)');
    ylabel('Probabilidad de error de s�mbolo (P_M)');
    grid on
     
    % Representaci�n de la probabilidad de error de bit
    figure(2)
    semilogy(SNRdb,errorsimuladob,'r*');
    hold on
    
    % Para la representaci�n del error te�rico
    SNRdb2 = 0:0.01:20;
    errorteorico=zeros(size(SNRdb2));

    for ii=1:length(SNRdb2),
        SNR = 10^(SNRdb2(ii)/10);% relaci�n se�al ruido
        errorteorico(ii)=(2*(M-1)/(M*log2(M)))*...
            Qfunct(sqrt((6*log2(M)/(M^2-1))*SNR));...
        echo off;
    end
    
    semilogy(SNRdb2,errorteorico,'-k','Color',color, 'LineWidth', 1);
    axis([0,20,1e-7,1])
    xlabel('Relaci�n Se�al/Ruido E_b/N_0 (dB)');
    ylabel('Probabilidad de error de bit equivalente (P_b)');
    grid on
end
