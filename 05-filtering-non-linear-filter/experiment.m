
% read image
[im, map]  = imread('sar.gif');
im = ind2rgb(im, map);
im = rgb2gray(im);
%figure, imshow(im);


% apply noise
im2 = imnoise(im, 'salt & pepper', 0.02);
%figure, imshow(im2);

% filter image
L = medfilt2(im,[3 3]);
figure, 
subplot(1,3,1), imshow(im), title('original')
subplot(1,3,2), imshow(im2), title('s&p noise')
subplot(1,3,3), imshow(L), title('median filter')

% structures
th = 10;
BW = im2bw(L);
%figure, imshow(BW);
figure;

c = [702
   667
   500
   121
    15];
r = [135
   116
    98
   358
   377];

BW2 = bwselect(BW,c,r,4);

figure,imshowpair(BW,BW2,'montage');

BW = im2bw(im);


BW2 = bwselect(BW,c,r,4);
figure,imshowpair(BW,BW2,'montage');






