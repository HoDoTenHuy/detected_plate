% function scaleImage = getScaleImage(Image)
%     scaleRange = zeros(1, 12);
%     scale = 1.0;
    scaleRange(1, 1) = 1.0;
%     for i = 2 : 6
%         scale = scale / 1.05;
%         scaleRange(1, i) = scale;
%     end
%     scale = 1.0;
%     for i = 7 : 12
%         scale = scale * 1.05;
%         scaleRange(1, i) = scale;
%     end
    save('scaleRange_2.mat','scaleRange');
% end