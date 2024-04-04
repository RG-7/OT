clear;
clc;

% Simplex Method Code 

A = [1 2 1 0 0;1 1 0 1 0;1 1 0 0 1];
B = [10; 6; 2];
C = [2 1 0 0 0];
Cost = [C 0];
A1 = [A B];
BV = [3 4 5]; % basic varibale cost

ZjCj = Cost(BV)*A1 - Cost;
Table = [A1; ZjCj];

Run = true;
while Run
    ZC = ZjCj(1:5);
    if any(ZC<0)
        fprintf("The Sol is not Optimal\n")
        [value1,piviot_col] = min(ZC);
        sol = A1(:,6);
        column = A1(:,piviot_col);
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
        Pkey = A1(piviot_row,piviot_col);
        A1(piviot_row,:) = A1(piviot_row,:)/Pkey;

        for i=1:3
            if i~= piviot_row
                A1(i,:) = A1(i,:) - A1(i,piviot_col)*A1(piviot_row,:);
            end
        end
        BV(piviot_row) = piviot_col;
        ZjCj = Cost(BV)* A1 - Cost;
        T = [A1;ZjCj];
        Table = array2table(T);
        Table.Properties.VariableNames(1:size(Table,2))={'x1','x2','s1','s2','s3','value of z'};
        disp(Table);
    else
        Run = false;
    end
end

% Optimal Solution
Optimal_sol = A1(:,6);
Optimal_value = ZjCj(6);
fprintf("Optimal Solution: %s\n", num2str(Optimal_sol'))
fprintf("Optimal Value: %f\n", Optimal_value)

% Date : April 03, 2024
% By: Ratn Govindam
