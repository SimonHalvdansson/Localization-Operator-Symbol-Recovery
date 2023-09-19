%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 80;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(2, M);

s = framenative2coef(Fa, symbol);

rec_wig = rec_accumulated_wigner(a, M, g, symbol);

close all;

fig = figure;
fig.Position = [100, 1000, 700, 250];

subplot(1, 2, 1);
imagesc(symbol);
colormap(flipud(gray));
colorbar;
title("Symbol");

subplot(1, 2, 2);
imagesc(rec_wig);
colormap(flipud(gray));
colorbar;
title("Weighted accumulated Wigner distribution");

print(fig, '-dpng', 'figures/weighted_accumulated_wigner_distribution_illustration.png');

