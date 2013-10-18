function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired toPIcs/clusters. 
%
% Output:
%     class: the assignment of each toPIc. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

%%Ziyi Jiang 902837691

%% Initialization

[Nd,Nw] = size(bow); % get the dimension of the input bow
tic
class = zeros(1,Nd); % initial class with bow's row dimension
maxR = 100;
minR = 0;

YU = randi([minR maxR],K,Nw); PI = randi([minR maxR],K,1);
 
%% Normalization    
for i = 1:K
    YUtp = 0;
    for j = 1:Nw
        
        YUtp = YU(i,j)+ YUtp;
        
    end
    for j = 1:Nw
        
        YU(i,j) = YU(i,j)/YUtp;
    end
    
end
    
PItp = 0;
for i = 1:K
    
PItp = PItp + PI(i);

end
for i = 1:K
    
PI(i) = PI(i)/PItp;   
end
    
%% implementation of EM 

EmR = zeros(K,Nd);

for iter=1:600 % get EmR
    
    for j = 1:Nd   
        
        EmRtp = 0;
        
        for i = 1:K  
            %three for loops :from class to individual text to whole text
           YUp = 1;
           
           for n = 1:Nw    
               
               YUp = YUp*(YU(i,n)^bow(j,n));
           end
           EmR(i,j)=PI(i)*YUp;
           
           EmRtp = EmRtp + EmR(i,j);
           
        end
        for i = 1:K
           EmR(i,j) = EmR(i,j)/EmRtp;
        end
    end



% Maximize and update Yu, PI 
    for i = 1:K   %three for loops :from class to individual text to whole text
        YUtp = 0;
        for j = 1:Nw   
            add = 0;
            
            for n = 1:Nd  
                
                add = add + EmR(i,n)*bow(n,j);
            end
            
            YU(i,j) = add;
            
            YUtp = YUtp + add;
        end

        for j = 1:Nw
            
            YU(i,j) = YU(i,j)/YUtp;
            
        end


        EmRadd = 0;
        for indD = 1:Nd   %whole text index
            
            EmRadd = EmRadd + EmR(i,indD);
            
        end
        PI(i) = EmRadd/Nd;          
    end

    [gabage,class]=max(EmR,[],1);
    

end
toc
  

end

