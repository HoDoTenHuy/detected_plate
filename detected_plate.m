clc; close all; clear;

hog.numBins = 9;

hog.numHorizCells = 9;
hog.numVertCells = 8;

hog.cellSize = 8;

hog.winSize = [(hog.numVertCells * hog.cellSize + 2), ...
               (hog.numHorizCells * hog.cellSize + 2)];

%%
threshold = 0;

fprintf('Getting the HOG descriptor for an example image...\n');

img = imread('ImageTest/1.jpg');
step = 8;
[h, w, ~] = size(img);

result_plate = [];
plate = [];
for i = 1:step:h
    for j =1:step:w        
        if (i + 65) < (h - 1) && (j + 73) < (w - 1)
             width = 65;
             height = 73;
             imagesc(img);
             rectangle('Position', [j, i, height, width],...
             'linewidth',2,...
             'linestyle','-',...
             'EdgeColor','r');
             drawnow;
             hold off;
             im = img(i:i+65,j:j+73);
             H = getHOGDescriptor(hog, im);

%%
             load('hog_model_plate_1.mat');

             p = H' * hog.theta;
             if (p > threshold)
                 fprintf('  This image contains a plate!\n');
                 result_plate = [result_plate; j, i, height, width];

                 plate = [plate; p, j, i, height, width];
             else
%              fprintf('  This image does not contain a plate!\n');
             end
        end
    end
end
if(isempty(result_plate))
    fprintf('  This image does not contain a plate!\n');
end
hold off;
figure,
imagesc(img);
[m, ~] = size(result_plate);
for i = 1 : m
    rectangle('Position', result_plate(i, :),...
    'linewidth',2,...
    'linestyle','-',...
    'EdgeColor','b');
end
[m, ~] = size(plate);
max_rs = max(plate(:, 1));
for i = 1:m
    if plate(i, 1) == max_rs
        image_plate = img(plate(i, 3):plate(i, 3)+plate(i, 4), plate(i, 2):plate(i, 2)+plate(i, 5));
        figure, imshow(image_plate);
    end
end
    
