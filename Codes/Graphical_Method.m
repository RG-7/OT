clc;
clear;

% Phase 1 : Input Parameter
C = [3 5];
A = [1 2; 1 1; 0 1];
B = [2000; 1500; 600];

% Phase 2 : Plotting a Graph
Y1 = 0:400:max(B); % Y1 = [ 0         400         800        1200        1600        2000 ]
X21 = (B(1) - A(1,1)*Y1)/A(1,2);
X22 = (B(2) - A(2,1)*Y1)/A(2,2);
X23 = (B(3) - A(3,1)*Y1)/A(3,2);

X21 = max(0,X21);
X22 = max(0,X22);
X23 = max(0,X23);

plot(Y1,X21,'r',Y1,X22,'k',Y1,X23,'b');
xlabel('Value of X1');
ylabel('Value of X2');
title('X1 v/s X2');
legend('x1 + 2x2 = 2000','x1 + x2 = 1500','x2 = 600');
grid on;

% Phase 3 : Find Corners Points with axis.
CX1 = find(Y1==0); % 1
C1 = find(X21==0); % 6
LINE1 = [Y1(:,[C1 CX1]); X21(:,[C1 CX1])]'; % 2 POINTS 1 LINE

C2 = find(X22==0); % 5 6
LINE2 = [Y1(:,[C2 CX1]); X22(:,[C2 CX1])]';% 3 POINTS 2 LINE

C3 = find(X23==0); % NOT FOUND
LINE3 = [Y1(:,[C3 CX1]); X23(:,[C3 CX1])]'; % 1 POINT 1 LINE
CORPT = unique([LINE1;LINE2;LINE3],'rows');

% Phase 4 : Find point of Intersection
HG = [0; 0];
for i=1:size(A,1)
    hg1=A(i,:);
    b1=B(i,:);
    for j=i+1:size(A,1)
        hg2=A(j,:);
        b2 = B(j,:);
        Aa = [hg1; hg2];
        Bb = [b1; b2];
        Xx = Aa\Bb;
        HG=[HG Xx];
    end
end
pt = HG';
