
%% 5.1 Plot single-sided amplitude spectrum

Fs = 256;                     % Sampling frequency
T = 1/Fs;                     % Sample time
t = (0:(size(lfp,1)-1))*T;    % Time vector

% use code from Lab 4
figure(1)

%% 5.2 Filter the data and compare to original

% some filter options...
% [b,a] = butter(???);
% [b,a] = cheby1(???);
% [b,a] = fir1(???);

% or a more detailed design
% d = designfilt(???);
% e.g. d = designfilt('bandpassfir', 'StopbandFrequency1', 6, 'PassbandFrequency1', 7, 'PassbandFrequency2', 9, 'StopbandFrequency2', 10, 'StopbandAttenuation1', 60, 'PassbandRipple', 0.1, 'StopbandAttenuation2', 60, 'SampleRate', 256);
% b = d.Coefficients; a=1;

yfilt = filtfilt(b,a,y);

% Plot the original and filtered singal...
figure(2)
% ???

% Plot the original and filtered spectrum...
figure(1)
% ???

% Examine the filter properties
figure(3)
plot(b)

figure(4)
freqz(b,a)

%% 5.3 Wavelet Transform...

% [coefs,f] = cwt(???);
figure (5)
% imagesc(???)

%% 5.4 Plot the position alongside the cwt...

% ???