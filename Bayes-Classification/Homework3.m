function Homework3
%This is the main function for homework 3
%You are asked to plugin your implementation for the funciton ModelFull,
%ModelDiagonal, and ModelSpherical

%Repeat the experiments for 100 times
N = 100;

err_Full = zeros(N,2);
err_Diagonal = zeros(N,2);
err_Spherical = zeros(N,2);


%Let p change from 0.1, 0.2, 0.5, 0.8, 0.9 to compare the performance of each classifier
p = 0.1;

for i = 1 : N
	
	[train, test] = SplitData(p);
	
	[err_train, err_test] = ModelFull(train, test);
	err_Full(i,:) = [err_train, err_test];
	
	[err_train, err_test] = ModelDiagonal(train, test);
	err_Diagonal(i,:) = [err_train, err_test];
	
	[err_train, err_test] = ModelSpherical(train, test);
	err_Spherical(i,:) = [err_train, err_test];
	
	
end

mean_err_Full = mean(err_Full);
mean_err_Diagonal = mean(err_Diagonal);
mean_err_Spherical = mean(err_Spherical);

fprintf('err_Full : %g, %g\n', mean_err_Full(1), mean_err_Full(2));
fprintf('err_Diagonal : %g, %g\n', mean_err_Diagonal(1), mean_err_Diagonal(2));
fprintf('err_Spherical : %g, %g\n', mean_err_Spherical(1), mean_err_Spherical(2));

end                                                                                                                             