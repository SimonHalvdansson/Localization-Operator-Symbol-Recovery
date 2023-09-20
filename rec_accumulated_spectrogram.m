function [acc_spec] = rec_accumulated_spectrogram(a, M, g, s)
    acc_spec = zeros(M);
    [Fa, Fs] = framepair('dgt', g, 'dual', a, M);
    N = a*M;

    [V, D] = framemuleigs(Fa, Fs, s, a*M);

    for k = 1:N
       acc_spec = acc_spec + real(D(k)) * abs(dgt(V(:, k), g, a, M)).^2;
    end
    
    [m, n] = size(V);
    totalInnerProduct = 0;
    prods = 0;

    for i = 1:m-1
        for j = i+1:m
            prods = prods + 1;
            totalInnerProduct = totalInnerProduct + abs(dot(V(i,:), V(j,:)))*real(D(i))*real(D(j));
        end
    end
    
    %averageInnerProduct = totalInnerProduct / prods

end