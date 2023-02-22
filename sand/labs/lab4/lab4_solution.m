
%% 4.1 Plot time series

load('chb_sample.mat')

y = data{5};

Fs = 256;                     % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(y);                % Length of signal
t = (0:L-1)*T;                % Time vector

% Plot singal...
figure(1)
plot(t,y)
title('EEG')
xlabel('Time [s]')

%% 4.2 Compute and plot Fourier Transform

NFFT = 2^13;
Y = fft(y,NFFT);
f = Fs/2*linspace(0,1,NFFT/2); % get frequency axis from zero up to Nyquist limit

% Plot single-sided amplitude spectrum.
figure(2)
plot(f,(abs(Y(1:length(f),:))))
ylabel('Amplitude')
xlabel('Frequency [Hz]')

% note: instead of fft many labs prefer pwelch or pmtm

Yp = periodogram(y,[],NFFT,'psd');
Yw = pwelch(y,500,[],NFFT,'psd');
f = Fs/2*linspace(0,1,NFFT/2); % get frequency axis from zero up to Nyquist limit

% Plot single-sided amplitude spectrum.
% figure(2)
d2p = 1./mean(diff(f));
hold on
plot(f,(sqrt(Yp(1:length(f)))))
plot(f,(sqrt(Yw(1:length(f)))))
hold off
ylabel('Amplitude')
xlabel('Frequency [Hz]')
set(gca,'YScale','log')

% note: instead of fft many labs prefer pwelch or pmtm


%% 4.3 Spectrogram...

figure(3)
subplot(3,3,[5 6 8 9])
[S,f,t] = spectrogram(y,4096,4096-100,512,256);
imagesc(t,f,log(abs(S)))
axis xy
xlabel('Time (s)'); ylabel('Frequency (Hz)')
ylim([0 50])
set(gca,'TickDir','out'); box off
subplot(3,3,[2 3])
plot(t,sum(abs(S).^2,1),'LineWidth',2)
axis tight; set(gca,'TickDir','out'); box off
subplot(3,3,[4 7])
plot(f,sum(abs(S),2),'LineWidth',2)
axis tight; box off; set(gca,'TickDir','out')
xlim([0 50])
camroll(90);

%% Wide vs Narrow-band Spectrograms...

figure(4)
subplot(2,1,1)
[S,f,t] = spectrogram(y,256,256-100,512,256);
imagesc(t,f,log(abs(S)))
axis xy
xlabel('Time (s)'); ylabel('Frequency (Hz)')
title('Wideband')
colorbar
cl1 = get(gca,'CLim');

subplot(2,1,2)
[S,f,t] = spectrogram(y,4096,4096-100,512,256);
imagesc(t,f,log(abs(S)))
axis xy
xlabel('Time (s)'); ylabel('Frequency (Hz)')
title('Narrowband')
colorbar


cl2 = get(gca,'CLim');

% Make the color range exactly the same
subplot(2,1,1)
set(gca,'Clim',[min(cl1(1),cl2(1)) max(cl1(2),cl2(2))])
subplot(2,1,2)
set(gca,'Clim',[min(cl1(1),cl2(1)) max(cl1(2),cl2(2))])
