%syms t2;

N=1024;
Fs=2*2500;
Ts=1/Fs;
t=(0: N-1)*Ts;

%Señal Moduladora 1 
M1=0.5;
F_mod1=10;
A_mod1=5;
S_mod1=A_mod1*cos(2*pi*F_mod1*t);
figure(1)
subplot(2,1,1); 
plot(t, S_mod1)
title("Señal Moduladora 1");

%Señal Portadora 1
%A_port=A_mod/M;
A_port1=1;
F_port1=700;
S_port1=A_port1*cos(2*pi*F_port1*t);
figure(1)
subplot(2,1,2); 
plot(t, S_port1)
title("Señal Portadora 1");

%Modulación AM 1 
AM1=ammod(S_mod1, F_port1, Fs, 0, A_port1);
figure(2)
plot(t, AM1)
title("Señal Modulada 1")

%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Primera señal modulada AM en el tiempo y espectro. 

%Señal Moduladora 2 
M2=0.5;
F_mod2=100;
A_mod2=10;
S_mod2=A_mod2*cos(2*pi*F_mod2*t);
figure(3)
subplot(2,1,1); 
plot(t, S_mod2)
title("Señal Moduladora 2");

%Señal Portadora 2
%A_port=A_mod/M;
A_port2=1;
F_port2=2000;
S_port2=A_port2*cos(2*pi*F_port2*t);
figure(3)
subplot(2,1,2); 
plot(t, S_port2)
title("Señal Portadora 2");

%Modulación AM 2 
AM2=ammod(S_mod2, F_port2, Fs, 0, A_port2);
figure(4)
plot(t, AM2)
title("Señal Modulada 2")

%MULTIPLEXACIÓN DE SEÑALES
Suma=AM1+AM2+7*cos(2*pi*20*t);
figure(5)
plot(t,Suma)
title("Señal Sumada AM")



%Espectro
Y=fft(AM1);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(6)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")


%Espectro
Y=fft(Suma);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(7)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of Suma(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")



%--------------Modulacion FM----------------------

m = Suma; %mensaje a modular

fDev = 50;
 
fc_fm = 2500;
Fs_fm=2*fc_fm;
mi=2;
t2 = (0:1/Fs:0.01);
 
s_fm = fmmod(m,fc_fm,Fs_fm,fDev);
% figure(8)
% plot(t, s_fm)
%xlabel('Time (s)')
%ylabel('Amplitude')
% legend('Modulated Signal')
Y=fft(s_fm);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs_fm*(0:(N/2))/N;
figure(8)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of signal FM modulada")
xlabel("f (Hz)")
ylabel("|P1(f)|")

fm_demod = fmdemod(s_fm,fc_fm,Fs_fm,fDev);
 
 
 
 
%Espectro SeÃ±al demodulada FM
Y=fft(fm_demod);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs_fm*(0:(N/2))/N;
figure(10)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of seÃ±al FM demodulada")
xlabel("f (Hz)")
ylabel("|P1(f)|")
 
figure(11)
plot(t,m,'c',t,fm_demod,'b--')
xlabel('Time (s)')
ylabel('Amplitude')
legend('Moduladora','Demodulacion FM')

%Filtros AM-------------------------------------------------------

%Filtrado de señal media
Wpass=[240 1200];
FiltradoBP=bandpass(fm_demod,Wpass,Fs);
Y=fft(FiltradoBP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(12)
subplot(2,1,1);
plot(f,P1) 
title("Filtrado despues de paso banda")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(12)
subplot(2,1,2);
plot(t,FiltradoBP);
title("Señal media filtrada en el tiempo")

%Filtrado de señal baja
FiltradoLP=lowpass(fm_demod,60,Fs);
Y=fft(FiltradoLP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(13)
subplot(2,1,1);
plot(f,P1) 
title("Filtrado despues de paso bajo")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(13)
subplot(2,1,2);
plot(t,FiltradoLP);
title("Señal baja filtrada en el tiempo")

%Filtrado de señal alta
FiltradoHP=bandpass(fm_demod,[1750 2200],Fs);
Y=fft(FiltradoHP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(14)
subplot(2,1,1);
plot(f,P1) 
title("Filtrado despues de paso alto")
xlabel("f (Hz)")
ylabel("|P1(f)|")
figure(14)
subplot(2,1,2);
plot(t,FiltradoHP);
title("Señal alta filtrada en el tiempo")

%Demodulación AM --------------------------------------------------

%Demodulado señal media
% demod_BP=amdemod(FiltradoBP,700,Fs);
% figure(15)
% subplot(2,1,1);
% plot(t,demod_BP)
% title("SEÑAL BP DEMODULADA DESPUES DE FILTRO")
% Y=fft(demod_BP);
% P2 = abs(Y/N);
% P1 = P2(1:N/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(N/2))/N;
% figure(15)
% subplot(2,1,2);
% plot(f,P1) 
% title("ESPECTRO DEMODULADA BP")
% xlabel("f (Hz)")
% ylabel("|P1(f)|")
% 
%Demodulado señal alta
demod_HP=amdemod(FiltradoHP,2000,Fs);
figure(16)
subplot(2,1,1);
plot(t,demod_HP)
title("SEÑAL HP DEMODULADA DESPUES DE FILTRO")
Y=fft(demod_HP);
P2 = abs(Y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(N/2))/N;
figure(16)
subplot(2,1,2);
plot(f,P1) 
title("ESPECTRO DEMODULADA HP")
xlabel("f (Hz)")
ylabel("|P1(f)|")

