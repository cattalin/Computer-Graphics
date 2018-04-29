function [newVertices, newFaces] =  loopSubdivision2(vertices, faces)

    global edgeVertice;
    global newIndexOfVertices;
	newFaces = [];
	newVertices = vertices;

	nVertices = size(vertices,2);
	nFaces    = size(faces,2);
	edgeVertice = zeros(nVertices, nVertices, 3);
	newIndexOfVertices = nVertices;

    vaIndex = faces(1,:);
    vbIndex = faces(2,:);
    vcIndex = faces(3,:);

    vpIndex = addEdgeVertice(vaIndex, vbIndex, vcIndex);
    vqIndex = addEdgeVertice(vbIndex, vcIndex, vaIndex);
    vrIndex = addEdgeVertice(vaIndex, vcIndex, vbIndex);

    fourFaces = [vaIndex,vpIndex,vrIndex; vpIndex,vbIndex,vqIndex; vrIndex,vqIndex,vcIndex; vrIndex,vpIndex,vqIndex]';
    newFaces  = [newFaces, fourFaces]; 
     % ------------------------------------------------------------------------ %
	% positions of the new vertices
	for v1=1:nVertices-1
		for v2=v1:nVertices
			vNIndex = edgeVertice(v1,v2,1);
            if (vNIndex~=0)
    			vNOpposite1Index = edgeVertice(v1,v2,2);
        		vNOpposite2Index = edgeVertice(v1,v2,3);

				if (vNOpposite2Index==0) % boundary case
 					newVertices(:,vNIndex) = 1/2*(vertices(:,v1)+vertices(:,v2));
				else
 					newVertices(:,vNIndex) = 3/8*(vertices(:,v1)+vertices(:,v2)) + 1/8*(vertices(:,vNOpposite1Index)+vertices(:,vNOpposite2Index));
                end;
            end;
        end;
    end;
    
	% ------------------------------------------------------------------------ %
    % adjacent vertices (using edgeVertice)
	adjVertice{nVertices} = [];

	for v=1:nVertices
		for vTmp=1:nVertices
			if (v<vTmp && edgeVertice(v,vTmp,1)~=0) || (v>vTmp && edgeVertice(vTmp,v,1)~=0)
				adjVertice{v}(end+1) = vTmp;
            end;
        end;	
    end;
    
	% ------------------------------------------------------------------------ %
    % new positions of the original vertices	
	for v=1:nVertices
		k = length(adjVertice{v});

		adjBoundaryVertices = [];
		for i=1:k
			vi = adjVertice{v}(i);
			if (vi>v) && (edgeVertice(v,vi,3)==0) || (vi<v) && (edgeVertice(vi,v,3)==0)
				adjBoundaryVertices(end+1) = vi;
			end;
		end;

		if (length(adjBoundaryVertices)==2) % boundary case
			newVertices(:,v) = 6/8*vertices(:,v) + 1/8*sum(vertices(:,adjBoundaryVertices),2);
		else
			beta = 1/k*( 5/8 - (3/8 + 1/4*cos(2*pi/k))^2 );
			newVertices(:,v) = (1-k*beta)*vertices(:,v) + beta*sum(vertices(:,(adjVertice{v})),2); 
		end;
    end;
 	
end

% ---------------------------------------------------------------------------- %
function vNIndex = addEdgeVertice(v1Index, v2Index, v3Index)
	global edgeVertice;
	global newIndexOfVertices;

	if (v1Index>v2Index) % setting: v1 <= v2
		vTmp = v1Index;
		v1Index = v2Index;
		v2Index = vTmp;
	end;
	
	if (edgeVertice(v1Index, v2Index, 1)==0)  % new vertex
		newIndexOfVertices = newIndexOfVertices+1;
		edgeVertice(v1Index, v2Index, 1) = newIndexOfVertices;
		edgeVertice(v1Index, v2Index, 2) = v3Index;
	else
		edgeVertice(v1Index, v2Index, 3) = v3Index;
	end;

	vNIndex = edgeVertice(v1Index, v2Index, 1);

    return;
end