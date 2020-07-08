clc;
clear
I = imread('../ImageTest/haha/34.jpg');
I = rgb2gray(I);
[h, w] = size(I);
k = 4166;
for i =1:65:h-65
    for j=1:74:w-74
        J = I(i:i+65, j:j+73);
%         figure, imshow(J);
        linkSave = '../ImageTest/hihi/';
        h = num2str(k);
        linkSave = strcat(linkSave, h);
        linkSave = strcat(linkSave, '.jpg');
        imwrite(J, linkSave);
        k = k + 1;
    end
end
