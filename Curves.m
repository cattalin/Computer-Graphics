%     t= linspace (-30,-1.6);% just as t = -30:0.01:-1.6
%     X= ((3*t)./(1+t.^3));
%     Y= ((3*t.^2)./(1+t.^3));
%     plot(X, Y, 'r');hold on
%     plot(Y, X, 'r');
%     plot(t, X, 'g');
%     plot(t, Y, 'b');
    
%     plot3(t, X, Y, 'r');hold on
%     plot3(X, t, Y, 'b');
%     plot3(X, Y, t, 'g');

t = linspace (-50, 50, 10000);
% X = 4-3*cos(3*t);
% Y = 3+2*sin(5*t);
X = 2 - t + t.*t - t.*t.*t + 6*t.*t.*t.*t;
Y = 1 + t + 2*t.*t + 3*t.*t.*t;
plot(X, Y, 'r');
