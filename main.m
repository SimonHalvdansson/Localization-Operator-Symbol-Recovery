%ltfatstart;
a = 10;
M = 40;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(1, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

rec_wn = rec_white_noise(h, g, a, M, 20, 1);
rec_as = rec_accumulated_spectrogram(a, M, g, s);
rec_aw = rec_accumulated_wigner(a, M, g, s);
rec_pt = rec_plane_tiling(a, M, g, h, 100);
rec_gp = rec_gabor_projection(a, M, g, h);

close all;

fig = figure;
fig.Position = [100, 1000, 2200, 250];

figs = 6;

titles = ["Symbol";
         "White noise";
         "Weighted accumulated spectrogram";
         "Weighted Wigner distribution";
         "Plane tiling";
         "Gabor projection"];

images = {symbol, rec_wn, rec_as, rec_aw, rec_pt, rec_gp};

%for i = [1,4]
for i = 1:figs
    subplot(1, figs, i);
    imagesc(images{i});
    colorbar;
    title(titles(i));
end

