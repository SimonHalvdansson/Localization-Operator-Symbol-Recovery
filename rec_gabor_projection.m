function [rec] = rec_gabor_projection(a, M, g, h)
    rec = zeros(M);
    N = a*M;

    for delta_n = 0:M-1
        for delta_m = 0:M-1
            %this TF shifts g to the relevant coordinate....
            f_shifted = circshift(g, delta_n*a);
            l = (0:N-1).';
            f = f_shifted.*exp(2*pi*1i * delta_m*l/M);
            
            %filters it...
            filtered = operator(h, f);
            
            %and computes the resulting dgt
            c = dgt(filtered, g, a, M);
            
            %the imaginary part should be zero here so we discard it
            rec(delta_m + 1, delta_n + 1) = real(c(delta_m + 1, delta_n + 1));
        end
    end

end