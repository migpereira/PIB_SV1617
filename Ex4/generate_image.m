% Define the image size and where you want the circle
rows = 50;
cols = 50;
radius = 20;
center = [25 25];  % In [X,Y] coordinates
% Make the circle
[xMat,yMat] = meshgrid(1:cols,1:rows);
distFromCenter = sqrt((xMat-center(1)).^2 + (yMat-center(2)).^2);
circleMat = distFromCenter<=radius;
% To get just the border
B = circleMat & ~bwmorph(circleMat,'erode',1);
figure, imshow(B)
 
%image=zeros(300,400,3); %initialize
%image(:,1:100,1)=0.5;   %Red (dark red)
%image(:,101:200,1)=1;   %Red (maximum value)
%image(1:100,:,2)=rand(100,400);  %Green