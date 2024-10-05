function [clusterNamesUp,clusterNamesDown,net7angle_Up,net7angle_Down] = name_clusters_up_down(centroids,yeoNetNames,YeoNum)

%Provide names for clusters based on angular distance to binary Yeo
%System Vectors
%returns vector where 1 indicates a "+" state and 0 indicates a "-" state
%centroids = kClusterCentroids;

[nparc,numClusters] = size(centroids);

networklabels = table2array(yeoNetNames(1:nparc,2));

numNets = YeoNum;
binaryNetVectors = ones(nparc,numNets) .* repmat((1:numNets),[nparc 1]); 
binaryNetVectors = double(binaryNetVectors == networklabels);

if numNets==2
    YeoNetNames = {'CEN+', 'DMN+', 'CEN-', 'DMN-'};
elseif numNets==3
    YeoNetNames = {'FPN+', 'DMN+', 'ATN+', 'FPN-', 'DMN-', 'ATN-'};
elseif numNets==4
    YeoNetNames = {'mPFC+', 'dlPFC+', 'TPJ+', 'VM+', 'mPFC-', 'dlPFC-', 'TPJ-', 'VM-'};
elseif numNets==5
    YeoNetNames = {'mPFC+', 'dlPFC+', 'TPJ+', 'VM+','FFA+', 'mPFC-',...
        'dlPFC-',  'TPJ-', 'VM-', 'FFA-'};
elseif numNets==7
    YeoNetNames = {'VIS+', 'SOM+', 'DAT+', 'VAT+', 'LIM+', 'FPN+', 'DMN+','VIS-',...
        'SOM-', 'DAT-', 'VAT-', 'LIM-', 'FPN-', 'DMN-'};
else
    YeoNetNames = {'VIS_A+', 'VIS_B+', 'SOM_A+', 'SOM_B+', 'DAT_A+', 'DAT_B+',...
        'VAT_A+', 'VAT_B+', 'LIM_A+', 'LIM_B+', 'FPN_C+', 'FPN_A+', 'FPN_B+',...
        'TPJ+', 'DMN_C+', 'DMN_A+', 'DMN_B+', 'VIS_A-', 'VIS_B-', 'SOM_A-',...
        'SOM_B-', 'DAT_A-', 'DAT_B-', 'VAT_A-', 'VAT_B-', 'LIM_A-', 'LIM_B-',...
        'FPN_C-', 'FPN_A-', 'FPN_B-','TPJ-', 'DMN_C-', 'DMN_A-', 'DMN_B-'};
end

% calculate cosine of angle between binary state vector and centroids

centroids_up = centroids .* (centroids > 0);
centroids_down = -1 * centroids .* (centroids < 0);     % make negative activity positive and get rid of positive activity

net7angle_Up = zeros(numClusters,numNets);
net7angle_Down = zeros(numClusters,numNets);

for K = 1:numClusters
    for B = 1:numNets
        net7angle_Up(K,B) = dot(centroids_up(:,K),binaryNetVectors(:,B))...
            /(norm(centroids(:,K))*norm(binaryNetVectors(:,B)));
        net7angle_Down(K,B) = dot(centroids_down(:,K),binaryNetVectors(:,B))...
            /(norm(centroids(:,K))*norm(binaryNetVectors(:,B)));
    end
end

% get index of minimum and assign names

clusterNamesUp = cell(numClusters,1);
clusterNamesDown = cell(numClusters,1);
for K = 1:numClusters       % for up and down separately, calculate closest network
    Up_ind = find(net7angle_Up(K,:) == max(net7angle_Up(K,:)));
    Down_ind = find(net7angle_Down(K,:) == max(net7angle_Down(K,:)));    %cos(0) = 1 so need max not min (like for E.D.)
    clusterNamesUp{K} = [YeoNetNames{Up_ind},'+'];
    clusterNamesDown{K} = [YeoNetNames{Down_ind},'-'];
end