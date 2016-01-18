function [ im ] = ReduceImageDimensionality( inputimage )
%REDUCEIMAGEDIMENSIONALITY Reduce the layers of the image to 1
%   Simple dimensionality reduction of the image to 1

[r, c, d] = size(inputimage);

if d==3
    im = (inputimage(:,:,1)+ inputimage(:,:,2) + inputimage(:,:,3))./3;
end

if d==2
    im = (inputimage(:,:,1)+ inputimage(:,:,2))./2;
end

if d==1
    im = inputimage;
end

end

