function fileList = getImagesInDir(imgDir, addDir)
    dirData = dir(imgDir);

    dirIndex = [dirData.isdir];  
    
    initList = {dirData(~dirIndex).name};

    fileList = {};
    
    imgNum = 1;
    
    % For each file in the directory...
    for i = 1 : length(initList)
    
        % Get the next filename.
        imgFile = char(initList(i));

        % Grab the filename's extension.
        if (length(imgFile) <= 3)
            continue;
        else
            extension = imgFile((length(imgFile) - 2) : length(imgFile));
        end
        
        % If this is an image file...
        if (strcmp(extension, 'png') == 1) || ...
           (strcmp(extension, 'PNG') == 1) || ...
           (strcmp(extension, 'jpg') == 1) || ...
           (strcmp(extension, 'JPG') == 1)
        
            % Add the path if requested.
			if (addDir == true)
				imgFile = strcat(imgDir, imgFile);
            end
            
            % Add the file to the output list.
			fileList{imgNum} = imgFile;
			
            imgNum = imgNum + 1;
        end
    end
end