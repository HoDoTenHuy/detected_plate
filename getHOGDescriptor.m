function H = getHOGDescriptor(hog, img)
 
% Empty vector to store computed descriptor.
H = [];

% Verify the input image size matches the HOG parameters.
assert(isequal(size(img), hog.winSize))

% ===============================
%    dao ham
% ===============================
hx = [-1,0,1];
hy = hx';

dx = filter2(hx, double(img));
dy = filter2(hy, double(img));

dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));
dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1)); 


angles = atan2(dy, dx);
magnit = ((dy.^2) + (dx.^2)).^.5;

% =================================
%     Compute Cell Histograms 
% =================================

histograms = zeros(hog.numVertCells, hog.numHorizCells, hog.numBins);

% For each cell in the y-direction...
for row = 0:(hog.numVertCells - 1)
    
    rowOffset = (row * hog.cellSize) + 1;
    
    % For each cell in the x-direction...
    for col = 0:(hog.numHorizCells - 1)
    
        colOffset = (col * hog.cellSize) + 1;
        
        % Compute the indices of the pixels within this cell.
        rowIndeces = rowOffset : (rowOffset + hog.cellSize - 1);
        colIndeces = colOffset : (colOffset + hog.cellSize - 1);
        
        % Select the angles and magnitudes for the pixels in this cell.
        cellAngles = angles(rowIndeces, colIndeces); 
        cellMagnitudes = magnit(rowIndeces, colIndeces);

        histograms(row + 1, col + 1, :) = getHistogram(cellMagnitudes(:), cellAngles(:), hog.numBins);
    end
    
end

% ===================================
%      chuan hoa block
% ===================================    
for row = 1:(hog.numVertCells - 1)    
    for col = 1:(hog.numHorizCells - 1)
        blockHists = histograms(row : row + 1, col : col + 1, :);

        magnitude = norm(blockHists(:)) + 0.01;
    
        normalized = blockHists / magnitude;
       
        H = [H; normalized(:)];
    end
end
    
end
