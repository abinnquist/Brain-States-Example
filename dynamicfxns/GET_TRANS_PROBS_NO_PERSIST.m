function [transitionProbabilityNoPer,transProbEndGivenStart] = GET_TRANS_PROBS_NO_PERSIST(kClusterAssignments,subjInd,numClusters)

% Calculate transition probabilities from sequential cluster assignments
% get rid of persistence, so you only look at transitions

kClusterAssignments = reshape(kClusterAssignments,length(kClusterAssignments),1); %convert to row vector
nobs=length(unique(subjInd));
possible_transitions = (numClusters)*(numClusters);
numTransitions = zeros(nobs,numClusters,numClusters);
scanSubs=unique(subjInd);

transProbEndGivenStart = zeros(size(numTransitions));
for N = 1:nobs
    subjMask = subjInd == scanSubs(N);
    subjMask = kClusterAssignments(subjMask)';
    subjMask = [subjMask(find(diff(subjMask) ~= 0)),subjMask(end)];
    for Kinitial = 1:numClusters
        for Kfinal = 1:numClusters
            numTransitions(N,Kinitial,Kfinal) = length(strfind(subjMask,[Kinitial Kfinal]));
        end
    end
    transProbEndGivenStart(N,:,:) = squeeze(numTransitions(N,:,:)) ./ repmat(sum(squeeze(numTransitions(N,:,:)),2),[1 numClusters]);
end

transProbEndGivenStart(isnan(transProbEndGivenStart)) = 0;
cl=1;
for k=1:numClusters
    transitionProbabilityNoPer(:,cl:cl+numClusters-1)=transProbEndGivenStart(:,:,k);
    cl=cl+numClusters;
end


