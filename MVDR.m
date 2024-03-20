function [s_t_MVDR, w_MVDR] = MVDR(matX, theta_s_hat)
    N = length(matX(:,1));
    L = length(matX(1,:));
    R_hat = zeros(N, N);
    for i = 1 : L
        R_hat = R_hat + matX(:,i) * conj(transpose(matX(:,i)));
    end
    R_hat = R_hat / L;
    R_hat_inv = inv(R_hat);

    w_MVDR = zeros(N, L);
    for k = 1 : L
        a_s = [];
        for m = 0 : N-1
            a_s = [a_s;exp(1i*pi*m*sin(pi * theta_s_hat(k) / 180))];
        end
        w_MVDR(:,k) = R_hat_inv * a_s / (conj(a_s).' * R_hat_inv * a_s);
    end 
    
    s_t_MVDR = [];
    for k = 1 : L
        s_t_MVDR(k) = transpose(conj(w_MVDR(:,k))) * matX(:,k);
    end
end