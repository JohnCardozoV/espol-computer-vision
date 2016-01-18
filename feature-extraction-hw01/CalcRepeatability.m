function repeatability = CalcRepeatability(image_filename, type)


I1 = imread(image_filename);
I1 = ReduceImageDimensionality(I1);
points1 = detectHarrisFeatures(I1);
[features1, valid_points1] = extractFeatures(I1, points1);
possible_correspondences = features1.NumFeatures;
%imrotate(I1,-50)
repeatability = zeros(10, 2);
index= 1;
step= 0.2;
start = 0.2;
until = 2;

if type==2
    step=0.02;
    start=0.02;
    until=0.2;
end

for scale = start:step:until
   
    %transform
    if type==1
        I2 = imresize(I1, scale);
    else 
        I2 = imnoise(I1, 'speckle');
    end
    
    % calculate matches
    points2 = detectHarrisFeatures(I2);
    [features2, valid_points2] = extractFeatures(I2, points2);
    [indexPairs, matchmetric] = matchFeatures(features1, features2);
    
    % show matches
%     matchedPoints1 = valid_points1(indexPairs(:, 1), :);
%     matchedPoints2 = valid_points2(indexPairs(:, 2), :);
%     figure; showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
     
    correspondences = size(matchmetric,1);
    rep_ratio = correspondences/possible_correspondences;
    repeatability(index, 1)=scale;
    repeatability(index, 2)=rep_ratio;
    index = index + 1;
end






 
 