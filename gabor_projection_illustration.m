%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 100;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(0, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

rec_gp = rec_gabor_projection(a, M, g, h);

%To find the impulse response, set up a new symbol
symbol_impulse = zeros(M, M);
symbol_impulse(1,1) = 1;

s_impulse = framenative2coef(Fa, symbol_impulse);
h_impulse = operatornew('framemul', Fa, Fs, s_impulse);

impulse_response = rec_gabor_projection(a, M, g, h_impulse);

deconv = ifft2(fft2(rec_gp) ./ fft2(impulse_response));

close all;

fig = figure;
fig.Position = [100, 1000, 1000, 220];

subplot(1, 3, 1);
imagesc(symbol);
colormap(flipud(gray));
colorbar;
title("Symbol");

subplot(1, 3, 2);
imagesc(rec_gp);
colormap(flipud(gray));
colorbar;
title("Gabor projection");

subplot(1, 3, 3);
imagesc(deconv);
colormap(flipud(gray));
colorbar;
title("Deconvolved");

print(fig, '-dpng', 'figures/gabor_projection_illustration.png');

