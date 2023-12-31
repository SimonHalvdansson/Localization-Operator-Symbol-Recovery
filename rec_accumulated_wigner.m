function [acc_wgn] = rec_accumulated_wigner(a, M, g, symbol)
    acc_wgn = zeros(a*M, a*M);
    N = a*M;
    [Fa, Fs] = framepair('dgt', g, 'dual', a, M);
    symbol = squish_matrix(symbol);
    s = framenative2coef(Fa, symbol);
    [V, D] = framemuleigs(Fa, Fs, s, a*M);
    
    for k = 1:N
       acc_wgn = acc_wgn + real(D(k)) * wignervilledist(V(:, k))*2;
    end
    
end