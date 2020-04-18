clear all
close all
clc

fg = imageSet('Camera Roll');
imre = read(fg(1),9);
imshow(faceDetector(imre));