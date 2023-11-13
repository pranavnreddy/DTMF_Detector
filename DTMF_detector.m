function DTMF_detector()
    fs = 8000;
    duration = 0.1;
    gap = 0.1;

    keys_pressed = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","*","#"};
    [filtered_signal_array_low, filtered_signal_array_high] = filter_DTMF(fs, duration, gap, keys_pressed);
    % [filtered_signal_array_low, filtered_signal_array_high] = remez_filter_DTMF(fs, duration, gap, keys_pressed);
    
    length(keys_pressed)
    output = "";
    for i = 1:length(keys_pressed)
        start_index = round((i-1)*(duration+gap)*(fs/4)+1);
        end_index = round(start_index + duration*(fs/4));

        low_press = filtered_signal_array_low(:,start_index:end_index);
        high_press = filtered_signal_array_high(:,start_index:end_index);

        % max_low = max(low_press,[],2)
        % max_high = max(high_press,[],2)
        [~,low_index] = max(max(low_press,[],2));
        [~,high_index] = max(max(high_press,[],2));

        output = append(output,select_key(low_index,high_index));
    end
    
    disp(output)
end

function [filtered_signal_array_low, filtered_signal_array_high] = filter_DTMF(fs, duration, gap, keys_pressed)
% Constants
% fs = 8000;  % Sampling frequency
% duration = 0.1;  % Duration of each key press (100 ms)
% gap = 0.1;  % 100 ms delay between keys

[t_total, z] = generate_wave(keys_pressed, fs, duration, gap);

t_total_half_sample = t_total(1:2:end);
t_total_quarter_sample = t_total_half_sample(1:2:end);

filtered_signal_p1 = remez_lowpass1(z,fs);
downsampled_signal_p1 = downsample(filtered_signal_p1, 2);

filtered_signal_low = remez_lowpass2(downsampled_signal_p1,fs/2);

filtered_signal_high = remez_highpass1(downsampled_signal_p1,fs/2);

% Downsample the filtered signal by 2-to-1

downsampled_signal_low = downsample(filtered_signal_low, 2);
downsampled_signal_high = downsample(filtered_signal_high, 2);

filter_order = 5;
passband_ripple = 0.2;
stopband_attenuation = 50;

% Assign values to the array
%filtered_signal_array_low_1 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 677, 717, passband_ripple, stopband_attenuation);
%filtered_signal_array_low_1 = low_f1(downsampled_signal_low, fs/4);
filtered_signal_array_low_1 = remez_band_filter(downsampled_signal_low,fs/4,677,717);



%filtered_signal_array_low_2 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 750, 790, passband_ripple, stopband_attenuation);
% filtered_signal_array_low_2 = low_f2(downsampled_signal_low, fs/4);
filtered_signal_array_low_2 = remez_band_filter_special(downsampled_signal_low,fs/4,750,790);

%filtered_signal_array_low_3 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 832, 872, passband_ripple, stopband_attenuation);
% filtered_signal_array_low_3 = low_f3(downsampled_signal_low, fs/4);
filtered_signal_array_low_3 = remez_band_filter_special(downsampled_signal_low,fs/4,832,872);


%filtered_signal_array_low_4 = cheby2_HL_filter(downsampled_signal_low, fs/4, filter_order, 921, 961, passband_ripple, stopband_attenuation);
% filtered_signal_array_low_4 = low_f4(downsampled_signal_low, fs/4);
filtered_signal_array_low_4 = remez_band_filter(downsampled_signal_low,fs/4,921,961);


filtered_signal_array_low=[filtered_signal_array_low_1;filtered_signal_array_low_2;filtered_signal_array_low_3;filtered_signal_array_low_4];

%filtered_signal_array_high_1 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 770, 810, passband_ripple, stopband_attenuation);
% filtered_signal_array_high_1 = high_f1(downsampled_signal_high, fs/4);
filtered_signal_array_high_1 = remez_band_filter_special(downsampled_signal_high,fs/4,770,810);


%filtered_signal_array_high_2 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 645, 685, passband_ripple, stopband_attenuation);
% filtered_signal_array_high_2 = high_f2(downsampled_signal_high, fs/4);
filtered_signal_array_high_2 = remez_band_filter_special(downsampled_signal_high,fs/4,645,685);



%filtered_signal_array_high_3 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 505, 545, passband_ripple, stopband_attenuation);
% filtered_signal_array_high_3 = high_f3(downsampled_signal_high, fs/4);
filtered_signal_array_high_3 = remez_band_filter_special(downsampled_signal_high,fs/4,505,545);



%filtered_signal_array_high_4 = cheby2_HL_filter(downsampled_signal_high, fs/4, filter_order, 350, 390, passband_ripple, stopband_attenuation);
% filtered_signal_array_high_4 = high_f4(downsampled_signal_high, fs/4);
filtered_signal_array_high_4 = remez_band_filter_special(downsampled_signal_high,fs/4,350,390);


filtered_signal_array_high=[filtered_signal_array_high_1;filtered_signal_array_high_2;filtered_signal_array_high_3;filtered_signal_array_high_4];

end