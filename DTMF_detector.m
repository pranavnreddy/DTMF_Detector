function DTMF_detector()
    fs = 8000;
    duration = 0.1;
    gap = 0.1;


    keys_pressed = {"1","8","4","D","A","B","C","3"};
    [filtered_signal_array_low, filtered_signal_array_high] = filter_DTMF(fs, duration, gap, keys_pressed);
    
    output = "";
    for i = 1:length(keys_pressed)
        start_index = round((i-1)*(duration+gap)*(fs/4)+1);
        end_index = round(start_index + duration*(fs/4));

        % max_low = max(low_press,[],2)
        % max_high = max(high_press,[],2)
        [~,low_index] = max(max(filtered_signal_array_low(:,start_index:end_index),[],2));
        [~,high_index] = max(max(filtered_signal_array_high(:,start_index:end_index),[],2));

        output = append(output, select_key(low_index,high_index));
    end
    
    disp(output)
end