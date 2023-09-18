%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 100;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(4, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

counts = [round(a*M) * 0.2, round(a*M) * 0.4, round(a*M) * 0.6, 1000];

N = length(counts);

close all;

fig = figure;
fig.Position = [100, 1000, 1000, 180];

for k = 1:N
    rec_pt = rec_plane_tiling(a, M, g, h, counts(k));

    subplot(1, N, k);

    imagesc(rec_pt);
    colormap(flipud(gray));
    colorbar;
    title("N = " + int2str(counts(k)));
end

print(fig, '-dpng', 'figures/plane_tiling_illustration.png');

