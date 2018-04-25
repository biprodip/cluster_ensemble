function selFeature=FC()

global totFeature trainData trainClass noClusters q b initCentroid uClasses;
 
 %initial centroid fixation
 initCentroid=zeros(noClusters,totFeature);
 for ui=1:noClusters
  initCentroid(ui,:)=trainData(find(trainClass==uClasses(ui),1),:);
 end
 
 tmpfeatureSet=zeros(q,b);
 kf=NaN(1,q);
 
 for i=1:q
  %get new b samples
  while (1)
    featureSample=ceil(totFeature*rand(1,b));%in 1xb size 1:totFeature range
    if length(unique(featureSample))==b      %check uniqeness of features  
    
      discardFlag=0;    
      res= ismember(tmpfeatureSet,featureSample);
      for rw=1:i
        if sum(res(rw,:))==b
            discardFlag=1;
            break;
        end
      end
      
      if discardFlag~=1
        break; %unique sample generated
      end
      
    end %if 
  end %end while(1)
  
  tmpfeatureSet(i,:)=featureSample;
  kf(1,i)=getKF(featureSample);  %Look for weighted sum or minimize only SSB
  
 end
  
 [~,indx]=min(kf);
 selFeature=tmpfeatureSet(indx,:);
end