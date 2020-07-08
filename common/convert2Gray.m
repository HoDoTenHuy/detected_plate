clc;
clear;
for i = 501: 553
    j = num2str(i);
    nameI = '../Image/Position/';
    nameI = strcat(nameI, j);
    nameI = strcat(nameI, '.jpg');
    I = imread(nameI);
    I = rgb2gray(I);
    I = imresize(I, [66, 74]);
    linkSave = '../Image/Pos-Gray/';
    linkSave = strcat(linkSave, j);
    linkSave = strcat(linkSave, '.jpg');
    imwrite(I, linkSave);
end