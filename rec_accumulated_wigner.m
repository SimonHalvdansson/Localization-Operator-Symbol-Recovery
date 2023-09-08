function [acc_wgn] = rec_accumulated_wigner(a, M, g, s)
    acc_wgn = zeros(a*M);
    N = a*M;
    [Fa, Fs] = framepair('dgt', g, 'dual', a, M);
    
    [V, D] = framemuleigs(Fa, Fs, s, a*M);
    
    for k = 1:N
       acc_wgn = acc_wgn + real(D(k)) * wignervilledist(V(:, k));
    end
    
    acc_wgn = acc_wgn([a*M/2+1:a*M, 1:a*M/2], :);
    acc_wgn = acc_wgn(a*M:-1:1, :);
end