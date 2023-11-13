function [filtered_signal, b, err] = remez_band_filter(z,fs,passbandedge,stopbandedge)

% Filter specifications
Fs = fs;             % Sampling frequency
passband_start = passbandedge;              % Cutoff frequency in Hz
passband_stop = stopbandedge;
N = 25;                % Filter order
% Normalized frequencies
normalized_passband_start = passband_start / (Fs / 2);
normalized_passband_stop = passband_stop / (Fs / 2);

% Frequency vector for the filter design
Frequencies = [0, normalized_passband_start - 0.1, normalized_passband_start, ...
               normalized_passband_stop, normalized_passband_stop + 0.0001, 1];

% Desired amplitude response
Amplitudes = [0, 0, 1, 1, 1, 0];

% Weights for the filter design
Weights = [5, 10, 5]; % Adjust the weight for the stopband to increase attenuation

% Filter design using Remez algorithm
[b, err] = firpm(N, Frequencies, Amplitudes, Weights);
filtered_signal = filter(b,1,z);

end