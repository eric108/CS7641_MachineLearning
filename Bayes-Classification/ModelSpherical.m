function [err_train, err_test] = ModelSpherical(train, test)
%You implment this function by assuming a spherical covariance matrix. 
%err_train is the error rate on the train data
%err_test is the error rate on the test data

%Programer: Ziyi Jiang
% I followed both the slides and codes provided by the professor and the
% one of the instruction online about how to implement naive bayes
% classfier,
% http://people.scs.carleton.ca/~oommen/Courses/COMP4106Fall12/BayesClassifiers.pdf
% There is no code there, so I still implemented the codes by myself.

%% get the training and testing data size
testNum = size(test,1);
trainNum = size(train,1);
dim = size(test,2)-1;
%% Partition the data into two sets, those belonging to class 0 and those belonging to class 1.
cl0 = train(train(:,5)==0,1:4);
cl1 = train(train(:,5)==1,1:4);
%% average of the data in various dimension
M0 = mean(cl0);
M1 = mean(cl1);
%% Buidling the sigma values used in convariance matrix
sig0 = std(cl0,1);
sig1 = std(cl1,1);

sig0 = sig0 .* sig0;
sig1 = sig1 .* sig1;

aver_sig0 = mean(sig0);
aver_sig1 = mean(sig1);

%% Calculating the diagonal covariance matrix
cov0 = diag(ones(1,4)*aver_sig0);
cov1 = diag(ones(1,4)*aver_sig1);

%% average the two matrices and generate the identical matrix for the bonus question----------Remove the comments below to do Bonus part
% temp = (cov0+cov1)/2;
% cov0 = temp;
% cov1 = temp;

%% one term used to calculate the possibility (you can find the equation in the reference URL)
a0 = 1/sqrt(2*pi)^dim/sqrt(norm(cov0));
a1 = 1/sqrt(2*pi)^dim/sqrt(norm(cov1));
%% check invertablity for class 0
if rank(cov0)~=4
    cov0 = cov0 + diag(zeros(1,4)+0.1);
end
Icov0 = inv(cov0);
%% check invertablity for class 1
if rank(cov1)~=4
    cov1 = cov1 + diag(zeros(1,4)+0.1);
end
Icov1 = inv(cov1);
%% Get the data with valid dimension
trainData = train(:,1:4);
testData = test(:,1:4);

pTrain = zeros(trainNum,2);

pcov0 = size(cl0,1)/trainNum;
pcov1 = size(cl1,1)/trainNum;
%% classify the training data
for i = 1:1:trainNum
    b0 = (trainData(i,:)-M0) * Icov0 * (trainData(i,:)-M0)';
    p0 = a0 * exp(-b0/2);
    
    b1 = (trainData(i,:)-M1) * Icov1 * (trainData(i,:)-M1)';
    p1 = a1 * exp(-b1/2);
    
    % Bayes function
    pTrain(i,1) = p0 * pcov0/(p0*pcov0 + p1*pcov1);
    pTrain(i,2) = p1 * pcov1/(p0*pcov0 + p1*pcov1);
end
%% pick the maximum one
[tmp,predictTrain] = max(pTrain,[],2);
predictTrain = predictTrain - 1;
%% check the error
result = predictTrain - train(:,5);
err_train = 1 - size(find(result == 0),1)/trainNum;

pTest = zeros(testNum,2);
%% Below is the same step used for testing data
for i = 1:1:testNum
    b0 = (testData(i,:)-M0) * Icov0 * (testData(i,:)-M0)';
    p0 = a0 * exp(-b0/2);
    
    b1 = (testData(i,:)-M1) * Icov1 * (testData(i,:)-M1)';
    p1 = a1 * exp(-b1/2);
    
    
    pTest(i,1) = p0 * pcov0/(p0*pcov0 + p1*pcov1);
    pTest(i,2) = p1 * pcov1/(p0*pcov0 + p1*pcov1);
end

[tmp,predictTest] = max(pTest,[],2);
predictTest = predictTest - 1;
result = predictTest - test(:,5);
err_test = 1 - size(find(result == 0),1)/testNum;



end