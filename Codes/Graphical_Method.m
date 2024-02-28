% Code For Graphical Method
clc; % Clear the command window
clear; % Clear the workspace
close all; % Close all figures
format short; % Set the format to short

% Input Parameters
c = [2 3]; % Cost coefficients
A = [1 1;6 2;1 5;1 0;0 1]; % Coefficient matrix for constraints
B = [4 ;8;4;3;3]; % Right-hand side vector for constraints

% Plotting Constraints
x1 = 0:1:max(B); % Range of x1 values for plotting
figure; % Create a new figure
for i = 1:size(A, 1)
    y = (B(i) - A(i, 1) * x1) / A(i, 2);
    plot(x1, max(0,y), 'LineWidth', 1); % Plot the constraint line
    hold on;
end
xlabel('x1'); % Label x-axis
ylabel('x2'); % Label y-axis
title('Constraints'); % Set title
grid on; % Turn on grid
legend('x1 + x2 <= -1', '-0.5x1 + x2 <= 2'); % Add legend with corrected labels

% Finding Intersection Points
intersectionPoints = [];
for i = 1:size(A, 1)
    for j = i+1:size(A, 1)
        A1 = A(i,:);
        B1 = B(i,:);
        A2 = A(j,:);
        B2 = B(j,:);
        X = inv([A1; A2]) * [B1; B2];
        if all(X >= 0) % Check if the solution is feasible
            intersectionPoints = [intersectionPoints; X'];
        end
    end
end

% Keeping only Feasible Region
feasiblePoints = [];
for i = 1:size(intersectionPoints, 1)
    if all(A * intersectionPoints(i,:)' <= B) % Check feasibility
        feasiblePoints = [feasiblePoints; intersectionPoints(i,:)];
    end
end

% Evaluating the Objective Function
if isempty(feasiblePoints) % Check if feasible region is empty
    disp('Unbounded or Infeasible'); % Display message
else
    objValues = feasiblePoints * c';
    if all(c >= 0) % Maximization problem
        [optimalValue, index] = max(objValues);
    else % Minimization problem
        [optimalValue, index] = min(objValues);
    end

    % Display Optimal Solution
    optimalPoint = feasiblePoints(index, :);
    fprintf("The optimal value of the function is %f at (%g,%g)\n", optimalValue, optimalPoint(1), optimalPoint(2));
end
% Code Ends
