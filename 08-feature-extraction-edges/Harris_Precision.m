%% ==================================================
% Example of Harris precision in a checkkerboard
%

I = checkerboard(50,2,2);

method='Harris';
C = corner(I, method,'SensitivityFactor',0.04);%%0.04 default value

figure
imshow(I);
hold
plot(C(:,1),C(:,2),'*r');
title('HARRIS Corner Points');

