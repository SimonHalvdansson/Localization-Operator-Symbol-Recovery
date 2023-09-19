%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 60;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(2, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

%rho_20, rho_200
rec_wn_20 = rec_white_noise(h, g, a, M, 20, 1);
rec_wn_200 = rec_white_noise(h, g, a, M, 200, 1);

%vartheta
vartheta = zeros(M, M);
[V, D] = framemuleigs(Fa, Fs, s, a*M);

for k = 1:a*M
   vartheta = vartheta + real(D(k))^2 * abs(dgt(V(:, k), g, a, M)).^2;
end

%symbol
symb_sq = symbol.^2;

%instead of doing matlab convolution, we can use the accumulated
%spectrogram which is preciselt f * |Vgg|^2
s_sq = framenative2coef(Fa, symb_sq);

symb_blur = abs(rec_accumulated_spectrogram(a, M, g, s_sq));

close all;

fig = figure;
fig.Position = [100, 1000, 1800, 200];

subplot(1, 5, 1);
imagesc(rec_wn_20);
colormap(flipud(gray));
colorbar;
title('\surd\rho_{20}');

subplot(1, 5, 2);
imagesc(rec_wn_200);
colormap(flipud(gray));
colorbar;
title('\surd\rho_{200}');

subplot(1, 5, 3);
imagesc(vartheta.^(0.5));
colormap(flipud(gray));
colorbar;
title('\surd\vartheta');

subplot(1, 5, 4);
imagesc(symb_blur.^(0.5));
colormap(flipud(gray));
colorbar;
title('\surdf^2 * |V_g g|^2');

subplot(1, 5, 5);
imagesc(symbol);
colormap(flipud(gray));
colorbar;
title('f');

exportgraphics(gcf,'figures/white_noise_illustration.png','Resolution',300) 
