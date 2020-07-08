clc;
clear;
j = 2073;
for i = 1:1682
    nameI = '../hihi/';
    if i < 10
        img = num2str(i);
        img = strcat('000', img);
        img = strcat(img, '.jpg');
        nameI = strcat(nameI, img);
    elseif i < 100
        img = num2str(i);
        img = strcat('00', img);
        img = strcat(img, '.jpg');
        nameI = strcat(nameI, img);
    elseif i < 1000
        img = num2str(i);
        img = strcat('0', img);
        img = strcat(img, '.jpg');
        nameI = strcat(nameI, img);
    else
        img = num2str(i);
        img = strcat(img, '.jpg');
        nameI = strcat(nameI, img);
    end
    I = imread(nameI);
    im = num2str(j);
    im = strcat(im, '.jpg');
    im = strcat('Images/Training/Negative/', im);
    imwrite(I, im);
    j = j + 1;
end