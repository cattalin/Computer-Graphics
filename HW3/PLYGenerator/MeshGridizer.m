ptCloud = pcread('teapot.ply');
pcshow(ptCloud);

x = ptCloud.Location(:,1);
y = ptCloud.Location(:,2);
z = ptCloud.Location(:,3);

x = double(x);
y = double(y);
z = double(z);

pc = pointCloud( [x(:), y(:), z(:)] );


k = boundary([x'; y'; z']');

trisurf(k, x(:),y(:),z(:), 'Facecolor','red','FaceAlpha',0.1)

pc = pointCloud( [x(:), y(:), z(:)] );
pcwrite(pc, 'teapotul.ply');