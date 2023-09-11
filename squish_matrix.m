function [output_matrix] = squish_matrix(mat)
    % Determine the size of the input matrix
    [rows, cols] = size(mat);
    
    % Calculate the number of rows in the squished part
    squished_rows = ceil(rows/2);
    
    % Create a matrix to store the squished results
    squished_matrix = zeros(squished_rows, cols);
    
    for i = 1:2:rows-1
        squished_matrix((i+1)/2, :) = (mat(i, :) + mat(i+1, :))/2;
    end
    
    % If the number of rows is odd, set the last row of squished_matrix to the last row of mat
    if mod(rows, 2) == 1
        squished_matrix(end, :) = mat(end, :);
    end
    
    % Construct the output matrix
    output_matrix = [squished_matrix; zeros(rows - squished_rows, cols)];
end