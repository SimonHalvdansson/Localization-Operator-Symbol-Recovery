%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
a = 10;
M = 60;
symbol_index = 2;

g = pgauss(a*M);
[Fa, Fs] = framepair('dgt', g, 'dual', a, M);

symbol = load_symbol(symbol_index, M);

s = framenative2coef(Fa, symbol);
h = operatornew('framemul', Fa, Fs, s);

rec_wn = rec_white_noise(h, g, a, M, 200, 1);
rec_as = rec_accumulated_spectrogram(a, M, g, s);
rec_aw = rec_accumulated_wigner(a, M, g, symbol);
rec_pt = rec_plane_tiling(a, M, g, h, a*M);
rec_gp = rec_gabor_projection(a, M, g, h);

close all;

fig = figure;
fig.Position = [100, 100, 2400, 150];

figs = 6;

titles = ["Symbol";
         "White noise";
         "W. acc. spectrogram";
         "W. acc. Wigner distribution";
         "Plane tiling";
         "Gabor projection"];

images = {symbol, rec_wn, rec_as, rec_aw, rec_pt, rec_gp};

% 2 = show, 1 = hide
showErrors = 1;

for i = 1:figs
    subplot(showErrors, figs, i);
    imagesc(images{i});
    colormap(flipud(gray));
    colorbar;
    title(titles(i));
    
    if i == 1
        continue;
    end

    if showErrors == 1
        continue;
    end
    
    subplot(2, figs, i+figs)
    diff = zeros(size(images{i}));
    er = 0;
    symb_size = 0;
    
    if isequal(size(symbol), size(images{i}))
        diff = abs(symbol - images{i});
        er = sum(sum(diff))/sum(sum(abs(symbol)));
    else
        [x, y] = meshgrid(1:M, 1:M);
        [xq, yq] = meshgrid(linspace(1, M, a*M), linspace(1, M, a*M));
        upscaled_symbol = interp2(x, y, symbol, xq, yq, 'cubic');
        
        diff = abs(upscaled_symbol - images{i});
        er = sum(sum(diff))/sum(sum(abs(upscaled_symbol)));
    end
    imagesc(diff)
    colormap(flipud(gray));
    colorbar;
    title(num2str(er*100)); 
end

exportgraphics(gcf,'figures/overview.png','Resolution',300) 

