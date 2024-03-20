function [s_t_hat, w_hat]= mybeam(matX, theta_s_hat, theta_i_hat, lamda)
%% basic setup
    N = length(matX(:,1));
    L = length(matX(1,:));
    R_hat = zeros(N, N);
    for i = 1 : L
        R_hat = R_hat + matX(:,i) * conj(transpose(matX(:,i)));
    end
    R_hat = R_hat / L;
    R_hat_inv = inv(R_hat);
%% apply uniform beamforming
    w_uni = zeros(N, L);
    for k = 1 : L
        a_s = [];
        for m = 0 : N-1
            a_s = [a_s;exp(1i*pi*m*sin(pi * theta_s_hat(k) / 180))];
        end 
        w_uni(:,k) = a_s / N;
        s_t_uni(k) = conj(w_uni(:,k)).' * matX(:,k);
    end 
%% apply LCMV
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
    
%% combined
    w_hat = lamda * w_uni + (1 - lamda) * w_LCMV;
    s_t_hat = zeros(1, L);
    for k = 1 : L
        s_t_hat(k) = conj(w_hat(:,k)).' * matX(:,k);
    end
end 