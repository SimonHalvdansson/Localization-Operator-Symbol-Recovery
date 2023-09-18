%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 50;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(5, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

rec_gp = rec_gabor_projection(a, M, g, h);

close all;

fig = figure;
fig.Position = [100, 1000, 700, 250];

subplot(1, 2, 1);
imagesc(symbol);
colormap(flipud(gray));
colorbar;
title("Symbol");

subplot(1, 2, 2);
imagesc(rec_gp);
colormap(flipud(gray));
colorbar;
title("Gabor projection");

print(fig, '-dpng', 'figures/gabor_projection_illustration.png');

