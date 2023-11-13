function [filtered_signal] = low_pass2(z,fs)
% Filter design specifications
passband_ripple = 0.2;             % Pass band ripple in dB
stopband_attenuation = 50;         % Stop band attenuation in dB
passband_freq = [0 950];          % Pass band frequency range in Hz
stopband_freq = [1200 1999];       % Stop band frequency range in Hz
sampling_freq = fs;              % Sampling frequency in Hz

% Normalize the cutoff frequencies
passband_freq_norm = passband_freq / (sampling_freq / 2);
normalized_stopband = stopband_freq / (sampling_freq / 2);
% Design the Chebyshev Type II filter
[b, a] = cheby2(8, stopband_attenuation, normalized_stopband(1), 'low');
% Apply the filter to the signal
filtered_signal = filter(b, a, z);

% Plot the pole-zero diagram and frequency response
%figure;

% Use fvtool for pole-zero plot
%subplot(2, 1, 1);
%fvtool(b, a, 'Analysis', 'polezero');

% Use freqz for frequency response plot
%subplot(2, 1, 2);
%freqz(b, a, 1024, sampling_freq);

end