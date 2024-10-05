function BSNetNames = getBSnetnames(preprocess_dir, BSdir, nparc, BSNum)
% Load in the fNIRS study MNI coordinates
mniCoords=strcat(preprocess_dir,filesep,'channel_mnicoords.csv');
mniCoords=table2array(readtable(mniCoords));

%Load in the Brain State MNI coordinates
warning off
BSloc=strcat(BSdir,filesep,'BS_',num2str(BSNum),...
    'Networks/',num2str(BSNum),'Network_centroidCoors.csv');
BSNetworks=readtable(BSloc);
BSNames=BSNetworks(:,[2,6,7]);

coords=table2array(BSNetworks(:,3:5));

% Loop to find the closest Yeo coordinate to the NIRS channel
% Uses pdist2 Euclidean distance
mindist=nan(nparc,1);
idx=nan(nparc,1);
for ch=1:nparc
    d = pdist2(mniCoords(ch,:), coords(:,:));
    [mindist(ch,1), idx(ch,1)] = min(d, [], 2);
end
warning on

BSNetNames=BSNames(idx,:);
