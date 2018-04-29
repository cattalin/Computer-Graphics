function write_ply(fname, P, C, F)

num = size(P, 2);
numFaces = size(F, 2);

header = 'ply\n';
header = [header, 'format ascii 1.0\n'];
header = [header, 'element vertex ', num2str(num), '\n'];
header = [header, 'property float32 x\n'];
header = [header, 'property float32 y\n'];
header = [header, 'property float32 z\n'];
% header = [header, 'property uchar red\n'];
% header = [header, 'property uchar green\n'];
% header = [header, 'property uchar blue\n'];
header = [header, 'element face ', num2str(numFaces), '\n'];
header = [header, 'property list uchar uint vertex_indices\n'];
header = [header, 'end_header\n'];

verticesData = [P'];

vertexPerFaceArray = ones(numFaces,1).*size(F, 1) ;
facesData = [vertexPerFaceArray, F'];

fid = fopen(fname, 'w');
fprintf(fid, header);
dlmwrite(fname, verticesData, '-append', 'delimiter', '\t', 'precision', 3);
dlmwrite(fname, facesData, '-append', 'delimiter', '\t', 'precision', 4);
fclose(fid);

