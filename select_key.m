function c = select_key(low, high)
    if(low == 1)
        if(high == 1)
            c = "1";
        elseif(high == 2)
            c = "2";
        elseif(high == 3)
            c = "3";
        elseif(high == 4)
            c = "A";
        end
    elseif(low == 2)
        if(high == 1)
            c = "4";
        elseif(high == 2)
            c = "5";
        elseif(high == 3)
            c = "6";
        elseif(high == 4)
            c = "B";
        end
    elseif(low == 3)
        if(high == 1)
            c = "7";
        elseif(high == 2)
            c = "8";
        elseif(high == 3)
            c = "9";
        elseif(high == 4)
            c = "C";
        end
    elseif(low == 4)
        if(high == 1)
            c = "*";
        elseif(high == 2)
            c = "0";
        elseif(high == 3)
            c = "#";
        elseif(high == 4)
            c = "D";
        end
    else
        error("Invalid low frequency")
    end
end