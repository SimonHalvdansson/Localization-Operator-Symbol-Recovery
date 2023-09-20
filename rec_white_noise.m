function [rho] = rec_white_noise(h, g, a, M, K, sigma)
    rho = zeros(M);
    N = a*M;
    %this array tracks the noise to estimate sigma
    total_noise = [];
   
    for k = 1:K
        noise = randn(N, 1).*(sigma*sigma);
        total_noise = cat(1, total_noise, noise);
        rho = rho + abs(dgt(operator(h, noise), g, a, M)).^2/K;
    end

    %normalization as we're estimating |f|^2
    rho = rho./var(total_noise);
    rho = rho.^(0.5);

end