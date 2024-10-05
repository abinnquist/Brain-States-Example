function [probsStruct, subIDs] = balanceUnevenSubs(subIDs,probsStruct)
% Used in compileDwell to make the length of scans equivalent when there
% are a different number of subjects from one scan to the next

if length(subIDs{1,1}) ~= length(subIDs{1,2})
    if length(subIDs{1,1}) < length(subIDs{1,2})
        addSubs=[];
        for s=1:length(subIDs{1,2})
            findSub=subIDs{1,2}(s,1);
            if ~ismember(findSub,subIDs{1,1})
                addSubs=[addSubs;findSub];
            end
        end
        
        locAdd=[];
        for ns=1:length(addSubs)
            [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,2});
        end

        newdwell1=nan(length(subIDs{1,1}),width(probsStruct(2).DwellTimeMean));
        newdwellMed1=nan(length(subIDs{1,1}),width(probsStruct(2).DwellTimeMedian));
        newRunRate1=nan(length(subIDs{1,1}),width(probsStruct(2).RunRate));
        newFrac1=nan(length(subIDs{1,1}),width(probsStruct(2).FractionalOccupancy));
        newnumTran1=nan(length(subIDs{1,1}),width(probsStruct(2).numTransitions));
        newTranProbs1=nan(length(subIDs{1,1}),width(probsStruct(2).transitionProbability));
        newProbNoPer1=nan(length(subIDs{1,1}),width(probsStruct(2).transitionProbNoPer));
        ct=1;
        for sb=1:length(subIDs{1,2})
            if ~ismember(sb,locAdd)
                newdwell1(sb,:)=probsStruct(1).DwellTimeMean(ct,:);
                newdwellMed1(sb,:)=probsStruct(1).DwellTimeMedian(ct,:);
                newRunRate1(sb,:)=probsStruct(1).RunRate(ct,:);
                newFrac1(sb,:)=probsStruct(1).FractionalOccupancy(ct,:);
                newnumTran1(sb,:)=probsStruct(1).numTransitions(ct,:);
                newTranProbs1(sb,:)=probsStruct(1).transitionProbability(ct,:);
                newProbNoPer1(sb,:)=probsStruct(1).transitionProbNoPer(ct,:);
                ct=ct+1;
            end
        end
        probsStruct(1).DwellTimeMean=newdwell1;
        probsStruct(1).DwellTimeMedian=newdwellMed1;
        probsStruct(1).RunRate=newRunRate1;
        probsStruct(1).FractionalOccupancy=newFrac1;
        probsStruct(1).numTransitions=newnumTran1;
        probsStruct(1).transitionProbability=newTranProbs1;
        probsStruct(1).transitionProbNoPer=newProbNoPer1;
        probsStruct(1).subIDs=subIDs{1,2};
    elseif length(subIDs{1,1}) > length(subIDs{1,2})
        addSubs=[];
        for s=1:length(subIDs{1,1})
            findSub=subIDs{1,1}(s,1);
            if ~ismember(findSub,subIDs{1,2})
                addSubs=[addSubs;findSub];
            end
        end

        for ns=1:length(addSubs)
            [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,1});
        end

        newdwell2=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMean));
        newdwellMed2=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMedian));
        newRunRate2=nan(length(subIDs{1,1}),width(probsStruct(1).RunRate));
        newFrac2=nan(length(subIDs{1,1}),width(probsStruct(1).FractionalOccupancy));
        newnumTran2=nan(length(subIDs{1,1}),width(probsStruct(1).numTransitions));
        newTranProbs2=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbability));
        newProbNoPer2=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbNoPer));
        ct=1;
        for sb=1:length(subIDs{1,1})
            if ~ismember(sb,locAdd)
                newdwell2(sb,:)=probsStruct(2).DwellTimeMean(ct,:);
                newdwellMed2(sb,:)=probsStruct(2).DwellTimeMedian(ct,:);
                newRunRate2(sb,:)=probsStruct(2).RunRate(ct,:);
                newFrac2(sb,:)=probsStruct(2).FractionalOccupancy(ct,:);
                newnumTran2(sb,:)=probsStruct(2).numTransitions(ct,:);
                newTranProbs2(sb,:)=probsStruct(2).transitionProbability(ct,:);
                newProbNoPer2(sb,:)=probsStruct(2).transitionProbNoPer(ct,:);
                ct=ct+1;
            end
        end

        probsStruct(2).DwellTimeMean=newdwell2;
        probsStruct(2).DwellTimeMedian=newdwellMed2;
        probsStruct(2).RunRate=newRunRate2;
        probsStruct(2).FractionalOccupancy=newFrac2;
        probsStruct(2).numTransitions=newnumTran2;
        probsStruct(2).transitionProbability=newTranProbs2;
        probsStruct(2).transitionProbNoPer=newProbNoPer2;
        probsStruct(2).subIDs=subIDs{1,1};
    end
end

if width(subIDs) > 2
    if length(subIDs{1,1}) ~= length(subIDs{1,3})
        if length(subIDs{1,1}) < length(subIDs{1,3})
            addSubs=[];
            for s=1:length(subIDs{1,3})
                findSub=subIDs{1,3}(s,1);
                if ~ismember(findSub,subIDs{1,1})
                    addSubs=[addSubs;findSub];
                end
            end
    
            locAdd=[];
            for ns=1:length(addSubs)
                [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,3});
            end
    
            newdwell1=nan(length(subIDs{1,1}),width(probsStruct(3).DwellTimeMean));
            newdwellMed1=nan(length(subIDs{1,1}),width(probsStruct(3).DwellTimeMedian));
            newRunRate1=nan(length(subIDs{1,1}),width(probsStruct(3).RunRate));
            newFrac1=nan(length(subIDs{1,1}),width(probsStruct(3).FractionalOccupancy));
            newnumTran1=nan(length(subIDs{1,1}),width(probsStruct(3).numTransitions));
            newTranProbs1=nan(length(subIDs{1,1}),width(probsStruct(3).transitionProbability));
            newProbNoPer1=nan(length(subIDs{1,1}),width(probsStruct(3).transitionProbNoPer));
            ct=1;
            for sb=1:length(subIDs{1,3})
                if ~ismember(sb,locAdd)
                    newdwell1(sb,:)=probsStruct(1).DwellTimeMean(ct,:);
                    newdwellMed1(sb,:)=probsStruct(1).DwellTimeMedian(ct,:);
                    newRunRate1(sb,:)=probsStruct(1).RunRate(ct,:);
                    newFrac1(sb,:)=probsStruct(1).FractionalOccupancy(ct,:);
                    newnumTran1(sb,:)=probsStruct(1).numTransitions(ct,:);
                    newTranProbs1(sb,:)=probsStruct(1).transitionProbability(ct,:);
                    newProbNoPer1(sb,:)=probsStruct(1).transitionProbNoPer(ct,:);
                    ct=ct+1;
                end
            end
            probsStruct(1).DwellTimeMean=newdwell1;
            probsStruct(1).DwellTimeMedian=newdwellMed1;
            probsStruct(1).RunRate=newRunRate1;
            probsStruct(1).FractionalOccupancy=newFrac1;
            probsStruct(1).numTransitions=newnumTran1;
            probsStruct(1).transitionProbability=newTranProbs1;
            probsStruct(1).transitionProbNoPer=newProbNoPer1;
            probsStruct(1).subIDs=subIDs{1,3};
        elseif length(subIDs{1,1}) > length(subIDs{1,3})
            addSubs=[];
            for s=1:length(subIDs{1,1})
                findSub=subIDs{1,1}(s,1);
                if ~ismember(findSub,subIDs{1,3})
                    addSubs=[addSubs;findSub];
                end
            end
    
            locAdd=[];
            for ns=1:length(addSubs)
                [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,1});
            end

            newdwell3=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMean));
            newdwellMed3=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMedian));
            newRunRate3=nan(length(subIDs{1,1}),width(probsStruct(1).RunRate));
            newFrac3=nan(length(subIDs{1,1}),width(probsStruct(1).FractionalOccupancy));
            newnumTran3=nan(length(subIDs{1,1}),width(probsStruct(1).numTransitions));
            newTranProbs3=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbability));
            newProbNoPer3=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbNoPer));
            ct=1;
            for sb=1:length(subIDs{1,1})
                if ~ismember(sb,locAdd)
                    newdwell3(sb,:)=probsStruct(3).DwellTimeMean(ct,:);
                    newdwellMed3(sb,:)=probsStruct(3).DwellTimeMedian(ct,:);
                    newRunRate3(sb,:)=probsStruct(3).RunRate(ct,:);
                    newFrac3(sb,:)=probsStruct(3).FractionalOccupancy(ct,:);
                    newnumTran3(sb,:)=probsStruct(3).numTransitions(ct,:);
                    newTranProbs3(sb,:)=probsStruct(3).transitionProbability(ct,:);
                    newProbNoPer3(sb,:)=probsStruct(3).transitionProbNoPer(ct,:);
                    ct=ct+1;
                end
            end
            probsStruct(3).DwellTimeMean=newdwell3;
            probsStruct(3).DwellTimeMedian=newdwellMed3;
            probsStruct(3).RunRate=newRunRate3;
            probsStruct(3).FractionalOccupancy=newFrac3;
            probsStruct(3).numTransitions=newnumTran3;
            probsStruct(3).transitionProbability=newTranProbs3;
            probsStruct(3).transitionProbNoPer=newProbNoPer3;
            probsStruct(3).subIDs=subIDs{1,1};
        end
    end

    if length(probsStruct(2).subIDs) ~= length(probsStruct(3).subIDs)
        if length(subIDs{1,2}) < length(subIDs{1,3})
            addSubs=[];
            for s=1:length(subIDs{1,3})
                findSub=subIDs{1,3}(s,1);
                if ~ismember(findSub,subIDs{1,2})
                    addSubs=[addSubs;findSub];
                end
            end
    
            locAdd=[];
            for ns=1:length(addSubs)
                [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,3});
            end
    
            newdwell2=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMean));
            newdwellMed2=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMedian));
            newRunRate2=nan(length(subIDs{1,1}),width(probsStruct(1).RunRate));
            newFrac2=nan(length(subIDs{1,1}),width(probsStruct(1).FractionalOccupancy));
            newnumTran2=nan(length(subIDs{1,1}),width(probsStruct(1).numTransitions));
            newTranProbs2=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbability));
            newProbNoPer2=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbNoPer));
            ct=1;
            for sb=1:length(subIDs{1,3})
                if ~ismember(sb,locAdd)
                    newdwell2(sb,:)=probsStruct(2).DwellTimeMean(ct,:);
                    newdwellMed2(sb,:)=probsStruct(2).DwellTimeMedian(ct,:);
                    newRunRate2(sb,:)=probsStruct(2).RunRate(ct,:);
                    newFrac2(sb,:)=probsStruct(2).FractionalOccupancy(ct,:);
                    newnumTran2(sb,:)=probsStruct(2).numTransitions(ct,:);
                    newTranProbs2(sb,:)=probsStruct(2).transitionProbability(ct,:);
                    newProbNoPer2(sb,:)=probsStruct(2).transitionProbNoPer(ct,:);
                    ct=ct+1;
                end
            end
            probsStruct(2).DwellTimeMean=newdwell2;
            probsStruct(2).DwellTimeMedian=newdwellMed2;
            probsStruct(2).RunRate=newRunRate2;
            probsStruct(2).FractionalOccupancy=newFrac2;
            probsStruct(2).numTransitions=newnumTran2;
            probsStruct(2).transitionProbability=newTranProbs2;
            probsStruct(2).transitionProbNoPer=newProbNoPer2;
            probsStruct(2).subIDs=subIDs{1,3};
        elseif length(subIDs{1,2}) > length(subIDs{1,3})
            addSubs=[];
            for s=1:length(subIDs{1,2})
                findSub=subIDs{1,2}(s,1);
                if ~ismember(findSub,subIDs{1,3})
                    addSubs=[addSubs;findSub];
                end
            end
    
            locAdd=[];
            for ns=1:length(addSubs)
                [locAdd(ns,1),~]=find(addSubs(ns,1)==subIDs{1,2});
            end
    
            newdwell3=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMean));
            newdwellMed3=nan(length(subIDs{1,1}),width(probsStruct(1).DwellTimeMedian));
            newRunRate3=nan(length(subIDs{1,1}),width(probsStruct(1).RunRate));
            newFrac3=nan(length(subIDs{1,1}),width(probsStruct(1).FractionalOccupancy));
            newnumTran3=nan(length(subIDs{1,1}),width(probsStruct(1).numTransitions));
            newTranProbs3=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbability));
            newProbNoPer3=nan(length(subIDs{1,1}),width(probsStruct(1).transitionProbNoPer)); 
            ct=1;
            for sb=1:length(subIDs{1,2})
                if ~ismember(sb,locAdd)
                    newdwell3(sb,:)=probsStruct(3).DwellTimeMean(ct,:);
                    newdwellMed3(sb,:)=probsStruct(3).DwellTimeMedian(ct,:);
                    newRunRate3(sb,:)=probsStruct(3).RunRate(ct,:);
                    newFrac3(sb,:)=probsStruct(3).FractionalOccupancy(ct,:);
                    newnumTran3(sb,:)=probsStruct(3).numTransitions(ct,:);
                    newTranProbs3(sb,:)=probsStruct(3).transitionProbability(ct,:);
                    newProbNoPer3(sb,:)=probsStruct(3).transitionProbNoPer(ct,:);
                    ct=ct+1;
                end
            end
            probsStruct(3).DwellTimeMean=newdwell3;
            probsStruct(3).DwellTimeMedian=newdwellMed3;
            probsStruct(3).RunRate=newRunRate3;
            probsStruct(3).FractionalOccupancy=newFrac3;
            probsStruct(3).numTransitions=newnumTran3;
            probsStruct(3).transitionProbability=newTranProbs3;
            probsStruct(3).transitionProbNoPer=newProbNoPer3;
            probsStruct(3).subIDs=subIDs{1,2};
        end
    end
end
