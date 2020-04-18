%load the information
close all;
clear all;
clc;

faceGalary = imageSet('face database1','recursive');
galaryNames = {faceGalary.Description};


[training,testing] = partition(faceGalary,[.8 .2]);

trainingFeature = zeros(19,10404);
featureCount = 1;

for i = 1:size(faceGalary,2)
    for j=1:faceGalary(i).Count
        sizeNormalizedImage = imresize(rgb2gray(read(faceGalary(i),j)),[150,150]);
        trainingFeatures(featureCount,:) = extractHOGFeatures(sizeNormalizedImage);
        trainingLabel{featureCount} = training(i).Description; 
        featureCount = featureCount + 1;
    end
    personIndex{i} = training(i).Description; 
end
    
faceClassifier = fitcecoc(trainingFeatures,trainingLabel);  % machine learning based classifier

test = imageSet('New folder');
figureNum = 1;

for i = 1: test.Count
    quaryImage = read(test,i);
    quaryFeatures = extractHOGFeatures(quaryImage);
    personLabel = predict(faceClassifier,quaryFeatures);
    booleanIndex = strcmp(personLabel,personIndex);
    integerIindex = find(booleanIndex);
    subplot(5,2,figureNum);imshow(quaryImage);title('Quary Face');
    subplot(5,2,figureNum + 1);imshow(read(training(integerIindex),1));title('Mmatched class');
    figureNum = figureNum + 2;
end



