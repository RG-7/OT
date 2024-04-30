clear;                                                                                                                                                                                                                                                      
clc;
format long;
% Steepest Descent Method
% Note:- 
%       - It is only used when function is given. 
%       -  To solve manually method is different & code's method is different.

%% 
a = 1;
b = 1/2;
f = @(x,y) (x*x-x*y+y*y);
grad = @(x,y) [2*x-y,2*y-x];
number_of_iterations = 4;

for i=1:number_of_iterations
    grad(a,b);
    d= -grad(a,b)/norm(grad(a,b)); % when you divide by norm its a unit vector
    fun = @(z) (a+z*d(1))^2 - (a+z*d(1))*(b+z*d(2)) + (b+z*d(2))^2;
    x1 = fminbnd(fun,0,10000);
    a = a+x1*d(1);
    b = b + x1*d(2);
end

fprintf("\n\tThe value of a = %d , b = %d",a,b);


% Ratn Govindam
