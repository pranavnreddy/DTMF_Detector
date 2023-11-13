
function [filtered_signal_array_low, filtered_signal_array_high] = filter_DTMF(fs, duration, gap, keys_pressed)
% Constants
% fs = 8000;  % Sampling frequency
% duration = 0.1;  % Duration of each key press (100 ms)
% gap = 0.1;  % 100 ms delay between keys

[~, z] = generate_wave(keys_pressed, fs, duration, gap);

filtered_signal_p1 = low_pass1(z,fs);
downsampled_signal_p1 = downsample(filtered_signal_p1, 2);

filtered_signal_low = low_pass2(downsampled_signal_p1,fs/2);

filtered_signal_high = high_pass1(downsampled_signal_p1,fs/2);

% Downsample the filtered signal by 2-to-1

downsampled_signal_low = downsample(filtered_signal_low, 2);
downsampled_signal_high = downsample(filtered_signal_high, 2);

filter_order = 5;
passband_ripple = 0.2;
stopband_attenuation = 50;


% Assign values to the array
filtered_signal_array_low_1 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 677, 717, passband_ripple, stopband_attenuation);
filtered_signal_array_low_2 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 750, 790, passband_ripple, stopband_attenuation);
filtered_signal_array_low_3 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 832, 872, passband_ripple, stopband_attenuation);
filtered_signal_array_low_4 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 921, 961, passband_ripple, stopband_attenuation);
filtered_signal_array_low=[filtered_signal_array_low_1;filtered_signal_array_low_2;filtered_signal_array_low_3;filtered_signal_array_low_4];

filtered_signal_array_high_1 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 770, 810, passband_ripple, stopband_attenuation);
filtered_signal_array_high_2 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 645, 685, passband_ripple, stopband_attenuation);
filtered_signal_array_high_3 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 505, 545, passband_ripple, stopband_attenuation);
filtered_signal_array_high_4 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 350, 390, passband_ripple, stopband_attenuation);
filtered_signal_array_high=[filtered_signal_array_high_1;filtered_signal_array_high_2;filtered_signal_array_high_3;filtered_signal_array_high_4];

end