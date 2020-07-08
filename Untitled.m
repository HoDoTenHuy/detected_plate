clc;
clear;
addpath('./ImageTest/');
I = imread('11.jpg');
[h, w, ~] = size(I);
imagesc(I);
for i = 1:65/2:h
    for j =1:73/2:w 
             width = 65/2;
             height = 73/2;
             rectangle('Position', [j, i, height, width],...
             'linewidth',2,...
             'linestyle','-',...
             'EdgeColor','r');
    end
end
