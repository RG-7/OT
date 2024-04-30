clear;
clc;

% Big M Method Code 
variables = {'x1', 'x2', 'x3', 'a1', 'a2', 'x4', 'sol'};
M = 1000;
A = [1 2 3 1 0 0 15;2 1 5 0 1 0 20;1 2 1 0 0 1 10];
Cost = [1 2 3 -M -M -1 0];
s = eye(size(A,1));
BV = [4, 5, 6];
total_column = 7;
total_column_A = 6;


ZjCj = Cost(BV)*A - Cost;
Table = [A; ZjCj];

Run = true;
while Run
    ZC = ZjCj(1:total_column_A);
    if any(ZC<0)
        fprintf("The Sol is not Optimal\n")
        [value1,piviot_col] = min(ZC);
        sol = A(:,total_column);
        column = A(:,piviot_col);
        if all(column<=0)
            error("LPP is Unbounded")
        end
        for i=1:3
            if column(i)>0
                ratio(i) = sol(i)/column(i);
            else
                ratio(i) = inf;
            end
        end
        [value2,piviot_row] =min(ratio);
        Pkey = A(piviot_row,piviot_col);
        A(piviot_row,:) = A(piviot_row,:)/Pkey;

        for i=1:3
            if i~= piviot_row
                A(i,:) = A(i,:) - A(i,piviot_col)*A(piviot_row,:);
            end
        end
        BV(piviot_row) = piviot_col;
        ZjCj = Cost(BV)* A - Cost;
        T = [A; ZjCj];
        Table = array2table(T);
        Table.Properties.VariableNames(1:size(Table,2))={'x1', 'x2', 'x3', 'a1', 'a2', 'x4', 'sol'};
        disp(Table);
    else
        Run = false;
    end
end

% Optimal Solution
Optimal_sol = A(:,total_column);
Optimal_value = ZjCj(total_column);
fprintf("Optimal Solution: %s\n", num2str(Optimal_sol'))
fprintf("Optimal Value: %f\n", Optimal_value)

% Date : April 03, 2024
% By: Ratn Govindam
