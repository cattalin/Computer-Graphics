function write_ply(fname, P, C, F)

num = size(P, 2);
numFaces = size(F, 1);
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

data = [P'];

fid = fopen(fname, 'w');
fprintf(fid, header);
dlmwrite(fname, data, '-append', 'delimiter', '\t', 'precision', 3);
dlmwrite(fname, F, '-append', 'delimiter', '\t', 'precision', 4);
fclose(fid);

