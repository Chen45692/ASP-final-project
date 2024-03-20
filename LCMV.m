function [s_t_LCMV, w_LCMV] = LCMV(matX, theta_s_hat, theta_i_hat) 
    %since d = lamda / 2, exp(2i*pi*d_m*sin(theta)/lamda) = exp(i*pi*m*sin(theta)),m=0~N-1
    N = length(matX(:,1));
    L = length(matX(1,:));
    R_hat = zeros(N, N);
    for i = 1 : L
        R_hat = R_hat + matX(:,i) * conj(transpose(matX(:,i)));
    end
    R_hat = R_hat / L;
    R_hat_inv = inv(R_hat);
    
    w_LCMV = zeros(N, L);
    for k = 1 : L
        a_s = [];
        a_i = [];
        for m = 0 : N-1
            a_s = [a_s;exp(1i*pi*m*sin(pi * theta_s_hat(k) / 180))];
            a_i = [a_i;exp(1i*pi*m*sin(pi * theta_i_hat(k) / 180))];
        end 
        C = [a_s, a_i];
        g = [1; 0];
        w_LCMV(:, k) = R_hat_inv * C * inv((conj(transpose(C)) * R_hat_inv * C)) * g;
    end
    s_t_LCMV = zeros(1, L);
    for k = 1 : L
        s_t_LCMV(k) = transpose(conj(w_LCMV(:,k))) * matX(:,k);
    end
end 