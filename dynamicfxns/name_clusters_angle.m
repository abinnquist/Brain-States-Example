function [clusterNames,reorderClusters,clusterNamesSort,net7angle,BS_Names] = name_clusters_angle(centroids, BS_Names,BSNum)

%Provide names for clusters based on angular distance to binary Brain State
%System Vectors
%returns vector where 1 indicates a "+" state and 0 indicates a "-" state
%centroids = kClusterCentroids;

[nparc,numClusters] = size(centroids);

networklabels = table2array(BS_Names(1:nparc,2));

numNets = BSNum;
% make a matrix where each column corresponds to a labeled BS system in Lausanne parcellation
% the columns are binary vectors indicated whether a region belongs to corresponding BS system

binaryNetVectors = ones(nparc,numNets) .* repmat((1:numNets),[nparc 1]); 
binaryNetVectors = double(binaryNetVectors == networklabels);
% then duplicate this matrix, multiply by -1 and horizontally concatenate to
% provide separate names for when systems are low amplitude

binaryNetVectors = [binaryNetVectors, -1*binaryNetVectors];

if numNets==2
    BS_Names = {'CEN+', 'DMN+', 'CEN-', 'DMN-'};
elseif numNets==3
    BS_Names = {'FPN+', 'DMN+', 'ATN+', 'FPN-', 'DMN-', 'ATN-'};
elseif numNets==4
    BS_Names = {'mPFC+', 'dlPFC+', 'TPJ+', 'SPL+', 'mPFC-', 'dlPFC-', 'TPJ-', 'SPL-'};
elseif numNets==5
    BS_Names = {'mPFC+', 'dlPFC+', 'TPJ+', 'SPL+','FFA+', 'mPFC-',...
        'dlPFC-',  'TPJ-', 'SPL-', 'FFA-'};
elseif numNets==7
    BS_Names = {'VIS+', 'SOM+', 'DAT+', 'VAT+', 'LIM+', 'FPN+', 'DMN+','VIS-',...
        'SOM-', 'DAT-', 'VAT-', 'LIM-', 'FPN-', 'DMN-'};
else
    BS_Names = {'VIS_A+', 'VIS_B+', 'SOM_A+', 'SOM_B+', 'DAT_A+', 'DAT_B+',...
        'VAT_A+', 'VAT_B+', 'LIM_A+', 'LIM_B+', 'FPN_C+', 'FPN_A+', 'FPN_B+',...
        'TPJ+', 'DMN_C+', 'DMN_A+', 'DMN_B+', 'VIS_A-', 'VIS_B-', 'SOM_A-',...
        'SOM_B-', 'DAT_A-', 'DAT_B-', 'VAT_A-', 'VAT_B-', 'LIM_A-', 'LIM_B-',...
        'FPN_C-', 'FPN_A-', 'FPN_B-','TPJ-', 'DMN_C-', 'DMN_A-', 'DMN_B-'};
end

% calculate cosine of angle between binary state vector and centroids

net7angle = zeros(numClusters,numNets*2);

for K = 1:numClusters
    for B = 1:(numNets*2)
        net7angle(K,B) = dot(centroids(:,K),binaryNetVectors(:,B))...
            /(norm(centroids(:,K))*norm(binaryNetVectors(:,B)));
    end
end

% get index of minimum and assign names

clusterNamesInit = cell(numClusters,1);
plusminus = true(numClusters,1);
for K = 1:numClusters
    ind = find(net7angle(K,:) == max(net7angle(K,:)));    %cos(0) = 1 so need max not min (like for E.D.)
    clusterNamesInit{K} = BS_Names{ind};
    if ind > numNets
        plusminus(K) = false;
    end
end

clusterNames = cellstr(clusterNamesInit);

%sort by name then plus-minus
%
[clusterNamesSort,I] = sort(clusterNamesInit);
[~,I2] = sort(plusminus(I));
clusterNamesSort = clusterNamesSort(I2);
reorderClusters = I(I2);
%}
