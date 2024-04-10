clear;
clc;
%% Phase 1: ----> Input Data
Cost = [8 1 3 5 6;2 8 4 7 8;3 1 5 2 9;5 3 1 6 9];
A = [6 12 18 24];
B = [17 14 15 16 10];

%% Phase 2: ---> Checking Balanced / Unbalanced
if sum(A)==sum(B)
    fprintf('Given Problem is Balanced\n')
else
    fprintf('Given Problem is unbalanced\n')
    if sum(A)<sum(B)
        Cost(end+1,:) = zeros(length(B),1);
        A(end+1) = sum(B)-sum(A);
    % else if sum(A)-sum(B)
    else
            Cost(:,end+1)=zeros(1,length(A),1);
            B(end+1) =sum(abs-sim(B));
    end
end
ICost = Cost;
X = zeros(size(Cost));
m = size(Cost,1);
n = size(Cost,2);

BFS = m+n-1;

%% Phase 3: ----> Finding cells with minimum cost 
for i=1:size(Cost,1)
    for j=1:size(Cost,2)
        hh =min(Cost(:));
        [Row_index,Col_index]=find(hh==Cost);
        X11 = min(A(Row_index),B(Col_index));
        [value,index] = max(X11);
        ii = Row_index(index);
        jj = Col_index(index);
        Y11 = min(A(ii),B(jj));
        X(ii,jj) = Y11;
        A(ii)=A(ii)-Y11;
        B(jj) =B(jj)-Y11;
        Cost(ii,jj) = Inf;
    end
end

fprintf('Initial BFS = \n');
IBFS = array2table(X);
disp(IBFS);

%% Phase 4: ----> Check Degenerate / Non-Degenerate 
Total_BFS = length(nonzeros(X));
if Total_BFS ==BFS
    fprintf('Initial BFS is Non-Degenerate\n');
else
    fprintf('Inital BFS is Degenerate\n');
end

%% Phase: 5----> Compute the Cost
Initial_Cost = sum(sum(ICost.*X));
fprintf('Inital BFS Cost is = %d\n',Initial_Cost);
