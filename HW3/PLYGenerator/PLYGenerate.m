
n=16;
T = linspace(0, 2*pi, n);
S = linspace(0, 2*pi, n);

[s, t] = meshgrid(S, T);
fx = @(s,t) cos(s).*(1+cos(t)).*sin(s/8);
fy = @(s,t) sin(t).*sin(s/8) + cos(s/8)*1.5;
fz = @(s,t) sin(s).*(1+cos(t)).*sin(s/8);

% fx = @(s,t) 3.*cos(s)+cos(t).*cos(s);
% fy = @(s,t) 3.*sin(s)+cos(t).*sin(s);
% fz = @(s,t) sin(t);

x = fx(s,t);x = double(x);
y = fy(s,t);y = double(y);
z = fz(s,t);z = double(z);

% x = x(1,:)
% y = y(1,:)
% z = z(1,:)

% pcshow([x(:),y(:),z(:)]);
s = surf(x, y, z,'FaceAlpha',0.5);
s.EdgeColor = 'none';

P = [x(:),y(:),z(:)]';
C = zeros(3,n^3);

F = zeros(length(P)/4,5);

i=1;

for i=1:2:(length(P))-n
    j=(i-1);
    F(i,:) = [4, j, j+1, j+n+1, j+n];
    F(i+1,:) = [4, j+1, j+2, j+n+2, j+n+1];
end

write_ply('custom.ply', P , C, F);

