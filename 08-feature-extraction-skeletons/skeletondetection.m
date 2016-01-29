fList = dir('images/*.gif');
numFiles = size(fList, 1);

for i=1:1:5
    
    fname = fList(i).name;
    fpath = ['images/', fname];
    img=imread(fpath); % Pick up 5 images an perform the home work
    %figure, imshow(img);
    
    %Make image greyscale
    if length(size(img)) == 3
        im =  double(img(:,:,2));
    else
        im = double(img);
    end

    %figure,imshow(im);
    bw = edge(im,'sobel');  % YOU SHOULD CHANGE THE PARAMETER OF THIS FUNCTION TO FIND THE SKELETON !!!
    figure;
    subplot(1,5,1), subimage(bw), title('EDGES SOBEL');

    % BW3 = bwmorph(im,'skel');
    % figure, imshow(BW3);
    % title('skel');

    D1 = bwdist(bw,'euclidean');
    D2 = bwdist(bw,'cityblock');
    D3 = bwdist(bw,'chessboard');
    D4 = bwdist(bw,'quasi-euclidean');

    [E1, th1] = edge(D1,'sobel');
    [E2, th2] = edge(D2,'sobel');
    [E3, th3] = edge(D3,'sobel');
    [E4, th4] = edge(D4,'sobel');

    t1 = [fname, '- Euclidean Distance: ' , num2str(th1)];
    t2 = [fname, '- City block Distance: ' , num2str(th2)];
    t3 = [fname, '- Chessboard Distance: ' , num2str(th3)];
    t4 = [fname, '- Quasi-Euclidean Distance: ' , num2str(th4)];
    %figure;
    subplot(1,5,2), subimage(mat2gray(D1)), title(t1)
    subplot(1,5,3), subimage(mat2gray(D2)), title(t2)
    subplot(1,5,4), subimage(mat2gray(D3)), title(t3)
    subplot(1,5,5), subimage(mat2gray(D4)), title(t4)
end