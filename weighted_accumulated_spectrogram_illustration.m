%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 40;
g = pgauss(a*M);

[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(2, M);

s = framenative2coef(Fa, symbol);

rec_as = rec_accumulated_spectrogram(a, M, g, s);

%To find the impulse response, set up a new symbol
symbol_impulse = zeros(M, M);
symbol_impulse(1,1) = 1;

s_impulse = framenative2coef(Fa, symbol_impulse);
impulse_response = rec_accumulated_spectrogram(a, M, g, s_impulse);

deconv = ifft2(fft2(rec_as) ./ fft2(impulse_response));

close all;

fig = figure;
fig.Position = [100, 1000, 800, 180];

subplot(1, 3, 1);
imagesc(symbol);
colormap(flipud(gray));
colorbar;
title("Symbol");

subplot(1, 3, 2);
imagesc(rec_as);
colormap(flipud(gray));
colorbar;
title("Weighted accumulated spectrograms");

subplot(1, 3, 3);
imagesc(deconv);
colormap(flipud(gray));
colorbar;
title("Deconvolved");

print(fig, '-dpng', 'figures/weighted_accumulated_spectrograms_illustration.png');

