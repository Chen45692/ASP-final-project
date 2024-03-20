function y = noise_filter(x, thr) 
%we can use Hilber_Huang transform to denoise the signal as long as the
%received signal is periodic-like
%% basic setup
    t = 1: length(x);
    temp = x;
    K = 100;    
    for i = 1 : K
        e_max = islocalmax(temp); e_max(1) = 1; e_max(end) = 1;   
        e_max = spline(t(e_max), temp(e_max), t);

        e_min = islocalmin(temp);  e_min(1) = 1; e_min(end) = 1;
        e_min = spline(t(e_min), temp(e_min), t);

        noise = temp - (e_max + e_min) / 2;       
        if abs(mean(noise)) < thr
            y = temp - noise;
            temp = y;
        else
            break;
        end
    end 
end 