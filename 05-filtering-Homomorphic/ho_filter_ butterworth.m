
% 
% MATLAB code that performs Homomorphic filtering, Using Butterworth
% High Pass Filter for performing filtering.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear all
d=10;
order=2;
im=double(imread('AT3_1m4_01.tif'));
%subplot(121)
%imshow(im./255);
[r c]=size(im);
imf = homofil(im,d,r,c,order);
imshowpair(im, imf, 'montage')