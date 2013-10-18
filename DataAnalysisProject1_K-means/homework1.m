function [] = homework1( image_name, K )
% This is a simple example to help you test your k-means implementation
% using an image. Please feel free to use the attached images, or your own
% images.
%
% An example of running this script is
%   homework1 ('beach.bmp', 4);
%
% You are not supposed to edit this file. Your job is implementing k-means
% in the other file, mykmeans.m. Have fun!

	image = imread(image_name);
	rows = size(image, 1);
	cols = size(image, 2);
	pixels = zeros(rows*cols, 3);

	for i=1:rows
		for j=1:cols
			pixels((j-1)*rows+i, 1:3) = image(i,j,:);
		end
	end

	[class, centroid] = mykmeans(pixels, K);

	converted_image = zeros(rows, cols, 3);
	for i=1:rows
		for j=1:cols
			converted_image(i, j, 1:3) = centroid(class((j-1)*rows+i),:);
		end
	end

	converted_image = converted_image / 255;
	imshow(converted_image);
end
