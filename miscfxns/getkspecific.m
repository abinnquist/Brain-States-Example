function [partition, clustNames, tickPlace, bestCentroid, tdist] = getkspecific(clusterAssignments,numClusters)

partition=clusterAssignments.(['k',num2str(numClusters)]).partition;
clustNames=clusterAssignments.(['k',num2str(numClusters)]).clusterNames;
tdist=clusterAssignments.(['k',num2str(numClusters)]).tdist;
bestCentroid=clusterAssignments.(['k',num2str(numClusters)]).bestCentroid;

if numClusters==2
    tickPlace=[1.5,2];
elseif numClusters==3
    tickPlace=[1.4,2.0,2.7];
elseif numClusters==4
    tickPlace=[1.4,2.2,3,3.8];
elseif numClusters==5
    tickPlace=[1.3,2.2,3.1,3.8,4.6];
elseif numClusters==6
    tickPlace=[1.4,2.2,3.1,3.9,4.7,5.6];
elseif numClusters==7
    tickPlace=[1.4,2.3,3.1,4,4.9,5.8,6.6];
elseif numClusters==8
    tickPlace=[1.4,2.3,3.1,4,4.9,5.8,6.6,7.6];
end
