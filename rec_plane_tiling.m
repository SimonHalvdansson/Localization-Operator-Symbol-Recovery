function [rec] = rec_plane_tiling(a, M, g, h, K)
    N = a*M;
    rec = zeros(M);

    for k = 0:K
        %let f_k be the k:th hermite
        fk = pherm(N, k);

        %and then translate it in time and frequency to the center
        fk = circshift(fk, a*M/2);
        l = (0:N-1).';
        fk = fk.*exp(2*pi*1i*l/2);

        rec = rec + abs(dgt(operator(h, fk), g, a, M)).^2;
    end
end