function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.
%  [class, centroid] = kmeans(pixels, K);

% YOUR IMPLEMENTATION SHOULD BE HERE!
  
    centroid = randi([0 255],K,3); %change the initial values here
    num = size(pixels,1);
    class = zeros(num,1);
    C = randi([0 K],num,1);

while (~isequal(class,C))
 
    C = class;
    distance = zeros(num,K);
    for i = 1:num
            distance = zeros(K,1);
            for k = 1:K
                d1 = (pixels(i,1)-centroid(k,1))^2;
                d2 = (pixels(i,2)-centroid(k,2))^2;
                d3 = (pixels(i,3)-centroid(k,3))^2;
                distance(k)= d1+d2+d3;
            end
            [d,c] = min(distance);  %d is the distance, c is the class
            class(i) = c;
    end
    count = zeros(K,1);
    for k = 1:K
            red = 0;
            green = 0;
            blue = 0;
            for i = 1:num
               if class(i)== k 
                   count(k)=count(k)+1;
                   red = red + pixels(i,1);
                   green = green + pixels(i,2);
                   blue = blue + pixels(i,3);
               end
            end
            centroid(k,1) = red/count(k);
            centroid(k,2) = green/count(k);
            centroid(k,3) = blue/count(k);         
    end 
end
end

