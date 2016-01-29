im1=imread('graffiti/img1.ppm');
im2=imread('graffiti/img2.ppm');
im3=imread('graffiti/img3.ppm');

im4=imread('IR/Infra1.bmp');
im5=imread('IR/Infra2.png');
im6=imread('IR/Infra3.png');

H1to2=load('graffiti/H1to2');
H1to3=load('graffiti/H1to3');

C1=Harris_Angel(im1);

figure
imshow(im1);
hold
plot(C1(:,1),C1(:,2),'*r');
title('HARRIS Corner Points 1');
ginput(1);

C2=Harris_Angel(im2);
figure
imshow(im2);
hold
plot(C2(:,1),C2(:,2),'*r');
title('HARRIS Corner Points 2');
ginput(1);

C3=Harris_Angel(im3);
figure
imshow(im3);
hold
plot(C3(:,1),C3(:,2),'*r');
title('HARRIS Corner Points 3');
ginput(1);

C1_Homogeneous = C1;
C1_Homogeneous(:,3) = 1;
C1_Homogeneous = C1_Homogeneous';

MapedC1to2=H1to2*C1_Homogeneous;
MapedC1to3=H1to3*C1_Homogeneous;

MapedC1to2(1,:)=MapedC1to2(1,:)./MapedC1to2(3,:);
MapedC1to2(2,:)=MapedC1to2(2,:)./MapedC1to2(3,:);
MapedC1to2(3,:)=MapedC1to2(3,:)./MapedC1to2(3,:);

MapedC1to3(1,:)=MapedC1to3(1,:)./MapedC1to3(3,:);
MapedC1to3(2,:)=MapedC1to3(2,:)./MapedC1to3(3,:);
MapedC1to3(3,:)=MapedC1to3(3,:)./MapedC1to3(3,:);


MapedC1to2=MapedC1to2';
MapedC1to3=MapedC1to3';

figure
imshow(im2);
hold
plot(C2(:,1),C2(:,2),'*r');
plot(MapedC1to2(:,1),MapedC1to2(:,2),'o y');
title('Corner Points from 1 Mapped to 2');
ginput(1);

figure
imshow(im3);
hold
plot(C3(:,1),C3(:,2),'*r');
plot(MapedC1to3(:,1),MapedC1to3(:,2),'o y');
title('Corner Points from 1 Mapped to 3');
ginput(1);

C4=Harris_Angel(im4);
figure
imshow(im4);
hold
plot(C4(:,1),C4(:,2),'*r');
title('HARRIS Corner Points LWIR');
ginput(1);


C5=Harris_Angel(im5);
figure
imshow(im5);
hold
plot(C5(:,1),C5(:,2),'*r');
title('HARRIS Corner Points LWIR');
ginput(1);

C6=Harris_Angel(im6);
figure
imshow(im6);
hold
plot(C6(:,1),C6(:,2),'*r');
title('HARRIS Corner Points LWIR');
ginput(1);

