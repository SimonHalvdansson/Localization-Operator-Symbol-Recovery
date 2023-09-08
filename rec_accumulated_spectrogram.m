function [acc_spec] = rec_accumulated_spectrogram(a, M, g, s)
    acc_spec = zeros(M);
    [Fa, Fs] = framepair('dgt', g, 'dual', a, M);
    N = a*M;

    [V, D] = framemuleigs(Fa, Fs, s, a*M);

    for k = 1:N
       acc_spec = acc_spec + real(D(k)) * abs(dgt(V(:, k), g, a, M)).^2;
    end
    
end