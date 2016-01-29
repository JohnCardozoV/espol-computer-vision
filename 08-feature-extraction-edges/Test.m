
listFiles = dir('images/*.ti*');
numFiles = size(listFiles, 1);

% calculate repeatability with respect to noise
figure;

for i=1:1:numFiles
    filename=listFiles(i).name;
    filepath = ['images/', filename];
    r = CalcRepeatability(filepath,1);
    hold on;
    plot(r(:,1), r(:,2), '-','Marker','x', 'DisplayName',filename);
    
end

title('Harris Repeatability with respect to scale');
xlabel('scale');
ylabel('% repeatability')
legend(gca,'show');

% calculate repeatability with respect to noise
figure;

for i=1:1:numFiles
    filename=listFiles(i).name;
    filepath = ['images/', filename];
    r = CalcRepeatability(filepath,2);
    hold on;
    plot(r(:,1), r(:,2), '-','Marker','x', 'DisplayName',filename);
    
end

title('Harris Repeatability with respect to noise');
xlabel('noise');
ylabel('% repeatability')
legend(gca,'show');
