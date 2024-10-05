function [transitionProbability,transitionProbabilityMatrices,numTransitions] = GET_TRANS_PROBS(partition,subjInd,numClusters)

% Calculate transition probabilities in a sequence of states
% partition: integer vector, sequential cluster assignments 
% subjInd: integer vector, subject index for partition
% numClusters: number of states (indexed 1:numClusters)
% Return 2D (transitionProbability) or 3D (transitionProbabilityMatrices)

partition = reshape(partition,length(partition),1); %convert to row vector
nobs = length(unique(subjInd));
if ~exist('numClusters','var')
	numClusters = length(unique(partition));
end
possible_transitions = (numClusters)*(numClusters);
numTrans = zeros(nobs,numClusters,numClusters);
scanSubs=unique(subjInd);

transitionProbabilityMatrices = zeros(size(numTrans));

for N = 1:nobs
    subjMask = subjInd == scanSubs(N);
    subjMask = partition(subjMask)';
    for Kinitial = 1:numClusters
        for Kfinal = 1:numClusters
            numTrans(N,Kinitial,Kfinal) = length(strfind(subjMask,[Kinitial Kfinal]));
        end
    end
    transitionProbabilityMatrices(N,:,:) = squeeze(numTrans(N,:,:)) ./ repmat(sum(squeeze(numTrans(N,:,:)),2),[1 numClusters]);
end

transitionProbabilityMatrices(isnan(transitionProbabilityMatrices)) = 0;

cl=1;
for k=1:numClusters
    transitionProbability(:,cl:cl+numClusters-1)=transitionProbabilityMatrices(:,:,k);
    numTransitions(:,cl:cl+numClusters-1)=numTrans(:,:,k);
    cl=cl+numClusters;
end