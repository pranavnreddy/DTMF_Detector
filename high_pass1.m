function [filtered_signal, b, a] = high_pass1(z,fs)
passband_ripple = 0.2;             % Pass band ripple in dB
stopband_attenuation = 50;         % Stop band attenuation in dB
passband_freq = [1200 1999];          % Pass band frequency range in Hz
stopband_freq = [0 950];       % Stop band frequency range in Hz
sampling_freq = fs / 2;              % Sampling frequency in Hz

% Normalize the cutoff frequencies
passband_freq_norm = passband_freq / (sampling_freq / 2);
normalized_stopband = stopband_freq / (sampling_freq / 2);
% Design the Chebyshev Type II filter
[b, a] = cheby2(8, stopband_attenuation, normalized_stopband(2), 'high');
% Apply the filter to the signal
filtered_signal = filter(b, a, z);
end