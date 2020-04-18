% im = imread('2.jpg');
% imresized = faceDetector(im);
% size(imresized)
% imshow(imresized);

clc;
clear all;
close all;

faceGallary = imageSet('face database1','recursive');
galaryNames = {faceGallary.Description};
quaryFileName = '2.jpg';
quaryFace = imread(quaryFileName);
figure;
imshow(quaryFace);
title('quary image');
quaryFace = faceDetector(quaryFace);
figure;
imshow(quaryFace);
title('detected face');
tic
features = detectSURFFeatures(quaryFace);
featureExtractionTime = toc
