function H = getHistogram(magnitudes, angles, numBins)

binSize = pi / numBins;

%range from 0 to pi.
minAngle = 0;

angles(angles < 0) = angles(angles < 0) + pi;

leftBinIndex = round((angles - minAngle) / binSize);
rightBinIndex = leftBinIndex + 1;

% For each pixel, compute the center of the bin to the left.
leftBinCenter = ((leftBinIndex - 0.5) * binSize) - minAngle;

rightPortions = angles - leftBinCenter;
leftPortions = binSize - rightPortions;
rightPortions = rightPortions / binSize;
leftPortions = leftPortions / binSize;

leftBinIndex(leftBinIndex == 0) = numBins;
rightBinIndex(rightBinIndex == (numBins + 1)) = 1;

% Create an empty row vector for the histogram.
H = zeros(1, numBins);

% For each bin index...
for i = 1:numBins
    % Find the pixels with left bin == i
    pixels = (leftBinIndex == i);
        
    % For each of the selected pixels, add the gradient magnitude to bin 'i',
    % weighted by the 'leftPortion' for that pixel.
    H(1, i) = H(1, i) + sum(leftPortions(pixels)' * magnitudes(pixels));
    
    % Find the pixels with right bin == i
    pixels = (rightBinIndex == i);
        
    % For each of the selected pixels, add the gradient magnitude to bin 'i',
    % weighted by the 'rightPortion' for that pixel.
    H(1, i) = H(1, i) + sum(rightPortions(pixels)' * magnitudes(pixels));
end    

end