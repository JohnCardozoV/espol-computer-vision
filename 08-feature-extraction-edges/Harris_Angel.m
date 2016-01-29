function C= Harris_Angel( inputimage )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% I = checkerboard(50,2,2);

[r c d] = size(inputimage);

if d==3
    im = (inputimage(:,:,1)+ inputimage(:,:,2) + inputimage(:,:,3))./3;
end

if d==2
    im = (inputimage(:,:,1)+ inputimage(:,:,2))./2;
end

if d==1
    im = inputimage;
end



method='Harris';
C = corner(im, method,'SensitivityFactor',0.04);%%0.04 default value



