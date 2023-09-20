%addpath(genpath('ltfat-2.6.0'));
%ltfatstart;
M = 60;
symbol_index = 7;

symbol = load_symbol(symbol_index, M);

titles = ["Circle";
         "Sum of Gaussians";
         "Wave";
         "Star";
         "Lines & circles";
         "Blurred lines & circles";
         "Tiles";
         "NTNU"];

fig = figure;
fig.Position = [100, 1000, 1000, 340];

im = 0;

for index = 0:7
    if index == 2
        continue;
    end
    
    im = im + 1;

    subplot(2, 4, im);
    imagesc(load_symbol(index, M));
    colormap(flipud(gray));
    colorbar;
    title(titles(index+1));
end

exportgraphics(gcf,'figures/all_symbols.png','Resolution',300) 
