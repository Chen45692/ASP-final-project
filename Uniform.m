function [s_t_uni, w_uni] = Uniform(matX,theta_s_hat)
    N = length(matX(:,1));
    L = length(matX(1,:));
    s_t_uni = zeros(1, L);
    w_uni = zeros(N, L);
    for k = 1 : L
        a_s = [];
        for m = 0 : N-1
            a_s = [a_s;exp(1i*pi*m*sin(pi * theta_s_hat(k) / 180))];
        end 
        w_uni(:,k) = a_s / N;
        s_t_uni(k) = conj(w_uni(:,k)).' * matX(:,k);
    end 
end 