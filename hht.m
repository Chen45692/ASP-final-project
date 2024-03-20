function c_n = hht(x, t, thr)
    c_n = [];                                                              %IMF
    K = 10;                                                                %randomly picked, 10 may be ok?
    %% step 1
    y = x;                                                                 %initail state
    for k = 1 : K
    %% step 2
        e_max = islocalmax(y); e_max(1) = 1; e_max(end) = 1;               %set boundary points as local maximum
    %% step 3
        e_max = spline(t(e_max), y(e_max), t);
    %% step 4
        e_min = islocalmin(y);
    %% step 5
        e_min = spline(t(e_min), y(e_min), t);
    %% step 6
        z = (e_max + e_min)./2;
        h_k = y - z;
    %% step 7
        check_max = islocalmax(h_k); check_max(1) = 1; check_max(end) = 1; %set boundary points as local maximum
        check_max = h_k(check_max);
    
        check_min = h_k(islocalmin(h_k));
        check = true;
        for i = 1 : length(check_max)                                      %all local max > 0
            if check_max(i) <= 0
                check = false;
                i = length(check_max);
            else
                continue;
            end
        end
    
        for i = 1 : length(check_min)                                      %all local min < 0
            if check_min(i) >= 0
                check = false;
                i = length(check_min);
            else
                continue;
            end
        end
        
        check_max = spline(1: length(check_max), check_max, t);
        check_min = spline(1: length(check_min), check_min, t);
        check_thr = abs(check_max + check_min) ./ 2;
    
        for i = 1 : length(t)
            if check_thr(i) >= thr
                check = false;
                i = length(t);
            end 
        end 
        
        count = 0;                                                         %extreme numbers 
        if check
            c_n = [c_n ; h_k];
            c_sum = zeros(1, size(h_k, 2));
            for i = 1 : size(c_n, 1) 
                c_sum = c_sum + c_n(i, :);
            end 
            count = 0;
            x_o = x - c_sum;
            x_ex = islocalmax(x_o);
            x_ex = islocalmin(x_o) + x_ex;
     
            for j = 1 : length(x_ex)
                if x_ex(j) == 1
                    count = count + 1;
                end
            end 
            
            if count >= 3
                y = x_o;
            else 
                break;                                                     %done
            end 
        else
            y = h_k;
        end 
    end

    %% trending plot
    % figure                                                                 
    % plot(t, x_o)
    % title("trend")
    % ylabel("Amplitude")
    % xlabel("time(second)")
end 