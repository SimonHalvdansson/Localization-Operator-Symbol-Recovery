function [symbol] = load_symbol(symb_index, M)
    
    symbol = zeros(M);

    if symb_index == 0 %Circle
        for i = 1:M
            for j = 1:M
                if (i - M/2)^2 + (j - M/2)^2 < (M/4)^2
                    symbol(i, j) = 1;
                end
            end
        end
    end

    if symb_index == 1 %Sum of Gaussians
        centers = [0.5, 0.5; 
           0.25, 0.25;
           0.7, 0.3;
           0.3, 0.8];

        weights = [1, 2, 3, 0.5, 0];

        for i = 1:M
            for j = 1:M
                for k = 1:4
                    symbol(i,j) = symbol(i,j) + weights(k) * exp(-((i-centers(k, 1)*M)^2/30 + (j-centers(k, 2)*M)^2/30));
                end
            end
        end
    end

    if symb_index == 2 %wave
        for i = 1:M
            for j = 1:M
                if abs(i - M/3) < M/8 && abs(j - M/3) < M/8
                    symbol(i,j) = 1;
                end
            
                if abs(i - M/5) < M/8 && abs(j - M/4) < M/8
                    symbol(i,j) = 1/2;
                end
            
                if (2*i-M/10)^2 + (j-M/1.6)^2 < 15*M/2
                    symbol(i,j) = i/4;
                end
            
                if abs((j-M*7/8)-10*sin((i-M/4))/3) < M/10
                    symbol(i,j) = 1.5;
                end
            end
        end
         
    end
   
    if symb_index == 3 %star
        symbol = double(imresize(rgb2gray(imread('star.png')), [M, M])) / 255;
    end

    if symb_index == 4 %lines and circles
        symbol = 1-double(imresize(rgb2gray(imread('lc.png')), [M, M])) / 255;

        borderWidth = M/40;

        scaledSize = round(M - 2*borderWidth);
        scaledImage = imresize(symbol, [scaledSize scaledSize]);
        
        borderedImage = zeros(M, M, size(symbol, 3), 'like', symbol);

        startIdx = round(borderWidth + 1);
        endIdx = round(borderWidth + scaledSize);
        borderedImage(startIdx:endIdx, startIdx:endIdx, :) = scaledImage;

        symbol = borderedImage;
    end

    if symb_index == 5 %blurred lines and circles
        unblurred = load_symbol(4, M);

        filter_dim = 3;
        sigma = 1;
        h = fspecial('gaussian', [filter_dim filter_dim], sigma);
        symbol = imfilter(unblurred, h);

        borderWidth = M/40;

        scaledSize = round(M - 2*borderWidth);
        scaledImage = imresize(symbol, [scaledSize scaledSize]);
        
        borderedImage = zeros(M, M, size(symbol, 3), 'like', symbol);

        startIdx = round(borderWidth + 1);
        endIdx = round(borderWidth + scaledSize);
        borderedImage(startIdx:endIdx, startIdx:endIdx, :) = scaledImage;

        symbol = borderedImage;
    end

    if symb_index == 6 %tiles
        for i = 1:M
            for j = 1:M
                if i > M/8 && i < 7*M/8 && j > M/8 && j < 7*M/8
                    if sin(14*i/M) > 0
                        if (sin(14*j/M) > 0)
                            symbol(i,j) = 1;
                        end
                    else
                        if sin(14*j/M) < 0
                            symbol(i,j) = 1;
                        end
                    end
                end
            end
        end
    end

    if symb_index == 7 %ntnu
        symbol = double(imresize(rgb2gray(imread('ntnu.png')), [M, M])) / 255*4;

        borderWidth = M/8;

        scaledSize = round(M - 2*borderWidth);
        scaledImage = imresize(symbol, [scaledSize scaledSize]);
        
        borderedImage = zeros(M, M, size(symbol, 3), 'like', symbol);

        startIdx = round(borderWidth + 1);
        endIdx = round(borderWidth + scaledSize);
        borderedImage(startIdx:endIdx, startIdx:endIdx, :) = scaledImage;

        symbol = borderedImage;
    end

end