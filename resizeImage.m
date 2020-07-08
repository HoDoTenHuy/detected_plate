function plateImage = resizeImage(ImageOrig, hog, step)
	im = rgb2gray(ImageOrig);
    im = double(im);
	% Initialize the windowCounts array.
    scaleRange = load('scaleRange.mat');
	plateImage = zeros(length(scaleRange.scaleRange)*40, 4);
    count = 1;
   
	
    % Try progressively smaller scales until a window doesn't fit.
    for i = 1 : length(scaleRange.scaleRange)
        
		% Get the next scale.
		scale = scaleRange.scaleRange(i);
		im = imresize(im, scale);
        [origImgHeight, origImgWidth] = size(im);
        % Compute the scaled img size.
        imgWidth = floor(origImgWidth * scale);
        imgHeight = floor(origImgHeight * scale);
    
        % Compute the number of cells horizontally and vertically for the image.
        numHorizCells = floor((imgWidth - 2) / hog.cellSize);
        numVertCells = floor((imgHeight - 2) / hog.cellSize);
        
        % Break the loop when the image is too small to fit a window.
                if ((numHorizCells < hog.numHorizCells) || ...
                    (numVertCells < hog.numVertCells))
                    break;
                end
        
        for j = 1:step:imgHeight
            for k =1:step:imgWidth
            %Compute the HOG descriptor for this image.
                if (j + 65) < (imgHeight - 1) && (k + 73) < (imgWidth - 1)
                    img = im(j:j+65,k:k+73);
                    H = getHOGDescriptor(hog, img);

            %%
            % Test if this image contains a person.

            % Load the pre-trained HOG model.
                    load('hog_model_plate_1.mat');

            % Evaluate the linear SVM on the descriptor.
                    p = H' * hog.theta;

             %              if (p > 0.3 && p < 0.45)
                    if (p > 0.4)
                        %fprintf('  This image contains a plate!\n');
                        width = 65;
                        height = 73;
                        %drawRectangle(k, j, height, width, 'r');
                        plateImage(count, :) = [k, j, height, width];
                        count = count + 1;
                    else
            %              fprintf('  This image does not contain a plate!\n');
                    end
                end
                if (k + 73) > imgWidth
                    break; 
                end
            end
            if (j + 65) > imgHeight
               break; 
            end
        end 
        % Compute the number of windows at this image scale.     
    end
end