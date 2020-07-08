addpath('./common/');
addpath('./svm/');
addpath('./svm/minFunc/');

hog.numBins = 9;

hog.numHorizCells = 9;
hog.numVertCells = 8;

hog.cellSize = 8;

hog.winSize = [(hog.numVertCells * hog.cellSize + 2), ...
               (hog.numHorizCells * hog.cellSize + 2)];

%%
posFiles = getImagesInDir('./Images/Training/Positive/', true);
negFiles = getImagesInDir('./Images/Training/Negative/', true);

y_train = [ones(length(posFiles), 1); zeros(length(negFiles), 1)];

fileList = [posFiles, negFiles];

% 7x8 blocks, 1 block = 4 cell(2x2), 1 cell = 9 bin => 7x8x4x9 = 2016.
X_train = zeros(length(fileList), 2016);

fprintf('Computing descriptors for %d training windows: ', length(fileList));
		
for i = 1 : length(fileList)

    imgFile = char(fileList(i));

    printIteration(i);
    
    img = imread(imgFile);
    
    H = getHOGDescriptor(hog, img);

    X_train(i, :) = H';
end

fprintf('\n');

%%
% Train

fprintf('\nTraining linear SVM classifier...\n');

hog.theta = train_svm(X_train, y_train, 1.0);

%save('hog_model_plate_1.mat', 'hog');

p = X_train * hog.theta;

numRight = sum((p > 0) == y_train);

fprintf('\nTraining accuracy: (%d / %d) %.2f%%\n', numRight, length(y_train), numRight / length(y_train) * 100.0);
