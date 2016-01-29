
lenaOri=imread('lena.JPG');
lenaGray=rgb2gray(lenaOri);
% ruido
lenaNoiseGaussian = imnoise(lenaGray, 'gaussian');
lenaNoisePoisson = imnoise(lenaGray, 'poisson');
lenaNoiseSP = imnoise(lenaGray, 'salt & pepper');

%figure, imshow(lenaGray);
%figure, imshow(lenaNoiseGaussian);

imwrite(lenaGray, 'lenaGray.jpg')
imwrite(lenaNoiseGaussian, 'lenaNoiseGaussian.jpg');
imwrite(lenaNoisePoisson,'lenaNoisePoisson.jpg');
imwrite(lenaNoiseSP,'lenaNoiseSP.jpg');



file = 'noise.dat';
delete(file)
[peaksnrG, snrG] = psnr(lenaNoiseGaussian, lenaGray)
m = [1, peaksnrG, snrG];
[peaksnrP, snrP] = psnr(lenaNoisePoisson, lenaGray)
m = [m;2, peaksnrP, snrP];
[peaksnrSP, snrSP] = psnr(lenaNoiseSP, lenaGray)
m = [m;3,peaksnrSP, snrSP];
csvwrite(file, m);

h=fspecial('gaussian');
lenaNoiseGaussianF = imfilter(lenaNoiseGaussian, h);
%figure, imshow(lenaGray);
%figure, imshow(lenaNoiseGaussian);
%figure, imshow(lenaNoiseGaussianF);
[peaksnrG, snrG] = psnr(lenaNoiseGaussianF, lenaGray)
m = [1, peaksnrG, snrG];

%remove
h=fspecial('unsharp');
lenaNoisePoissonF = imfilter(lenaNoisePoisson, h);
[peaksnrP, snrP] = psnr(lenaNoisePoisson, lenaGray)
m = [m;2, peaksnrP, snrP];

%remove salt & pepper
lenaNoiseSPF=medfilt2(lenaNoiseSP);
[peaksnrSP, snrSP] = psnr(lenaNoiseSPF, lenaGray)
m = [m;3,peaksnrSP, snrSP];

imwrite(lenaNoiseGaussianF, 'lenaNoiseGaussianF.jpg');
imwrite(lenaNoisePoissonF,'lenaNoisePoissonF.jpg');
imwrite(lenaNoiseSPF,'lenaNoiseSPF.jpg');


%figure, imshow(lenaGray);
%figure, imshow(lenaNoiseSP);
%figure, imshow(lenaNoiseSPF);







% figure, imshow(lenaGray);
hz=fspecial('sobel');
hz2=fspecial('gaussian');
PQ=paddedsize(size(lenaGray));
HZ=fft2(double(hz), PQ(1), PQ(2));
HZ2=fft2(double(hz2), PQ(1), PQ(2));
F=fft2(double(lenaGray),PQ(1),PQ(2));
alpha=0.01;
FDF=(alpha)*HZ.*F + (1-alpha)*HZ2.*F;
fdf=ifft2(FDF);
fdf=fdf(1:size(lenaGray,1),1:size(lenaGray,2));
figure,imshow(fdf,[])
%imwrite(fdf, 'lenaFreq1.jpg');

hz=fspecial('sobel');
hz2=fspecial('gaussian');
PQ=paddedsize(size(lenaGray));
HZ=fft2(double(hz), PQ(1), PQ(2));
HZ2=fft2(double(hz2), PQ(1), PQ(2));
F=fft2(double(lenaGray),PQ(1),PQ(2));
alpha=0.1;
FDF=(alpha)*HZ.*F + (1-alpha)*HZ2.*F;
fdf=ifft2(FDF);
fdf=fdf(1:size(lenaGray,1),1:size(lenaGray,2));
figure,imshow(fdf,[])

hz=fspecial('sobel');
hz2=fspecial('gaussian');
PQ=paddedsize(size(lenaGray));
HZ=fft2(double(hz), PQ(1), PQ(2));
HZ2=fft2(double(hz2), PQ(1), PQ(2));
F=fft2(double(lenaGray),PQ(1),PQ(2));
alpha=1;
FDF=(alpha)*HZ.*F + (1-alpha)*HZ2.*F;
fdf=ifft2(FDF);
fdf=fdf(1:size(lenaGray,1),1:size(lenaGray,2));
figure,imshow(fdf,[])
% 
