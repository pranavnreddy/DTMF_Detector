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

        % Select correct range from time series
        low_press = filtered_signal_array_low(:,start_index:end_index);
        high_press = filtered_signal_array_high(:,start_index:end_index);

        % Detect maximal output among 4 filters in given timespan
        [~,low_index] = max(max(low_press,[],2));
        [~,high_index] = max(max(high_press,[],2));

        output = append(output,select_key(low_index,high_index));
    end
    
    disp(output)
end