i=imread('images/bat-13.gif'); % Pick up 5 images an perform the home work
%figure, imshow(i);
%Make image greyscale
if length(size(i)) == 3
	im =  double(i(:,:,2));
else
	im = double(i);
end

%figure,imshow(im);
bw = edge(im,'sobel');  % YOU SHOULD CHANGE THE PARAMETER OF THIS FUNCTION TO FIND THE SKELETON !!!
figure, imshow(bw);
title('EDGES SOBEL');

%BW3 = bwmorph(im,'skel');
%figure, imshow(BW3);
%title('skel');


D1 = bwdist(bw,'euclidean');
D2 = bwdist(bw,'cityblock');
D3 = bwdist(bw,'chessboard');
D4 = bwdist(bw,'quasi-euclidean');

f1 = mat2gray(D1);
figure, imshow(f1), title('Euclidean Distance Transform')
%figure, imshow(mat2gray(D2)), title('City block Distance Transform')
%figure, imshow(mat2gray(D3)), title('Chessboard Distance Transform')
%figure, imshow(mat2gray(D4)), title('Quasi-Euclidean Distance Transform')

[bw2, threshOut, gpuarrayBW] = edge(f1,'sobel',0.007);
figure, imshow(bw2), title('Euclidean Distance Transform Edge')

