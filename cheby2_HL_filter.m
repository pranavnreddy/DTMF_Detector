function [filtered_signal, b, a] = cheby2_HL_filter(z, fs, n, passband_edge, stopband_edge, passband_ripple, stopband_attenuation)

% passband_edge = 770;        % passband edge in Hz
% stopband_edge = 810;       % stopband edge in Hz
% passband_ripple = 0.2;       % passband ripple
% stopband_attenuation = 50;         % stopband attenuation
% fs = fsamp;% sampling frequency

wp =  passband_edge / (fs/2);  % convert to radians per second
ws =  stopband_edge / (fs/2);  % convert to radians per second

% n = 5;  % order

[b, a] = cheby2(n, stopband_attenuation, [wp ws], 'bandpass');


filtered_signal = filter(b, a, z);

% figure;
% freqz(b, a, 1024, fs);
% title('Chebyshev Type II Bandpass Filter Frequency Response: high4');
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% grid on;
end