% Code for Basic Feasiable Solution 
%  Q1

% Maximize Z = 2x1 + 3x2 + 4x3 + 7x4
% s.t. 2x1 + 3x2 − x3 + 4x4 = 8
% x1 − 2x2 + 6x3 − 7x4 = −3
% xi ≥ 0 ∀ i = 1 − 4.
 clc
 clear all
 format short

 %phase 1 input the parameter
 A = [2 3 -1 4;1 -2 6 -7];
B = [8; -3];
c = [2 3 4 7];
objective = 1;% Objective Function Values
 % 
 %phase 2 no of constraints and variables
 m=size(A,1);
 n=size(A,2);
%  
 %phase 3 compute ncm bfs
 if n>=m
    nab=nchoosek(n,m);%total no of atmost basic sol.
    t=nchoosek(1:n,n-m); %pair of basic sol

    sol=[];
    for i=1:nab 
        y=zeros(n,1);
        X=A(:,t(i,:))\B;
        % 
        %To check the feasibility cond.
        if all(X>=0 & X~=inf & X~=-inf)
            if any(X==0)
                fprintf('Solution is degenerate\n');
            else
                fprintf('solution is non degenerate\n');
            end
            y(t(i,:))=X;
            sol=[sol y];
        end
    
    end
   
    % 
    % To print objective function
    Z=c*sol;
    if objective==1
        [zmax zind]=max(Z);
        bfs=sol(:,zind);
        optimal_value=[bfs' zmax]
    else
        [zmax zind]=min(Z);
        bfs=sol(:,zind);    
        optimal_value=[bfs' zmin]
    end 
    optimal_bfs=array2table(optimal_value);
    optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x1','x2','x3','x4','value of z'}
 else
     error('Equation is larger than variable');
 end
