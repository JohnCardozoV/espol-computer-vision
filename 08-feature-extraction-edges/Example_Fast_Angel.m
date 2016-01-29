%i = imread('lab.pgm');
i1=imread('graffiti/img1.ppm');

i2=imread('IR/Infra1.bmp');
i3=imread('IR/Infra2.png');
i4=imread('IR/Infra3.png');


%Make image greyscale
if length(size(i1)) == 3
	im =  double(i1(:,:,2));
else
	im = double(i1);
end

c9 = fast9(im, 30,1);

axis image
colormap(gray)

imshow(im / max(im(:)));
hold on
plot(c9(:,1), c9(:,2), 'r.')
title('9 point FAST');
ginput(1);

%Make image greyscale
if length(size(i2)) == 3
	im =  double(i2(:,:,2));
else
	im = double(i2);
end

c9 = fast9(im, 30,1);

axis image
colormap(gray)

figure
imshow(im / max(im(:)));
hold on
plot(c9(:,1), c9(:,2), 'r.')
title('9 point FAST');
ginput(1);

%Make image greyscale
if length(size(i3)) == 3
	im =  double(i3(:,:,2));
else
	im = double(i3);
end

c9 = fast9(im, 30,1);

axis image
colormap(gray)

figure
imshow(im / max(im(:)));
hold on
plot(c9(:,1), c9(:,2), 'r.')
title('9 point FAST');
ginput(1);

%Make image greyscale
if length(size(i4)) == 3
	im =  double(i4(:,:,2));
else
	im = double(i4);
end

c9 = fast9(im, 30,1);

axis image
colormap(gray)

figure
imshow(im / max(im(:)));
hold on
plot(c9(:,1), c9(:,2), 'r.')
title('9 point FAST');
ginput(1);

