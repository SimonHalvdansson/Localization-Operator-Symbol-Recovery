function [symbol] = load_symbol(symb_index, M)
    
    symbol = zeros(M);

    if symb_index == 0
        for i = 1:M
            for j = 1:M
                if (i - M/2)^2 + (j - M/2)^2 < (M/4)^2
                    symbol(i, j) = 1;
                end
            end
        end
    end

    if symb_index == 1
        centers = [M/2, M/2; 
           M/5, M/5;
           4*M/5, M/4;
           M/6, 4*M/5;
           4*M/5, 3*M/5];

        weights = [1, 2, 3, 0, 0];

        for i = 1:M
            for j = 1:M
                for k = 1:5
                    symbol(i,j) = symbol(i,j) + weights(k) * exp(-((i-centers(k, 1))^2/5 + (j-centers(k, 2))^2/5));
                end
            end
        end
    end

    if symb_index == 2
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
            
                if abs((j-M*7/8)-10*sin((i-M/4))/3) < M/10 && abs(i-M/2) > M/10
                    symbol(i,j) = 2;
                end
            end
        end
    end
   
    if symb_index == 3
        symbol = double(imresize(rgb2gray(imread('star.png')), [M, M])) / 255;
    end


end