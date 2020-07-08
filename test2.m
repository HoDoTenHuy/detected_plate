% function windowCounts = countWindows(hog, img, scaleRange)
    img = imread('ImageTest/1.jpg');
    [h, w, ~] = size(img);
    
    load('scaleRange_1.mat');
	load('hog_model_plate_1.mat');
    threshold = 0.2;
    % Try progressively smaller scales until a window doesn't fit.
    for k = 1 : length(scaleRange)
        
		% Get the next scale.
		scale = scaleRange(k)
		
        % Compute the scaled img size.
        winWidth = floor(hog.winSize(2) * scale);
        winHeight = floor(hog.winSize(1) * scale);
    
        % Compute the number of cells horizontally and vertically for the image.
        numHorizCells = floor((w - 2) / winWidth);
        numVertCells = floor((h - 2) / winHeight);
        step = 8;
        % "Plot" the image.
        result_plate = [];
        for i = 1:step:h
            for j =1:step:w        
        %Compute the HOG descriptor for this image. 
                if (i + winHeight-1) < (h - 1) && (j + winWidth-1) < (w - 1)
                    width = winWidth-1;
                    height = winHeight-1;
                    imagesc(img);
                    rectangle('Position', [j, i, width, height],...
                    'linewidth',2,...
                    'linestyle','-',...
                    'EdgeColor','r');
                    drawnow;
                    hold off;
                    im = img(i:i+height,j:j+width);
                    im = imresize(im, [66, 74]);
                    H = getHOGDescriptor(hog, im);

%%
                    p = H' * hog.theta;
             
                    if (p > threshold)
                        fprintf('  This image contains a plate!\n');
                        result_plate = [result_plate; j, i, width, height];
                    else
%                       fprintf('  This image does not contain a plate!\n');
                    end
                end
            end
        end
    end       
% end