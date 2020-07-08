clc;
clear;
addpath('./graphics/');
% Read in the pre-cropped (66 x 130) image.
img = imread('ImageTest/14.jpg');
[h, w, n] = size(img);
% "Plot" the image.
hold off;

for i = 1:4:h
    for j =1:4:w
        imagesc(img);
        
%Compute the HOG descriptor for this image.
        if (i + 65) < (h - 1) && (j + 73) < (w - 1)
             im = img(i:i+65,j:j+73);
             width = 65;
             height = 73;
             
            rectangle('Position', [j, i, height, width],...
            'linewidth',2,...
            'linestyle','-',...
            'EdgeColor','r');
            hold on;
            drawnow;
%             pause(0.5);
        end
    end
end
