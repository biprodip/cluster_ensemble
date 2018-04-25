function res_kf=getKF(features) 
  %input features: a feature set
  %output res_kf: cluster quality measure
  
  global totTrain trainData noClusters initCentroid;

  %kmeans on projected data on b features
  projData=zeros(totTrain,length(features));
  projData=trainData(:,features); 
  iCentroid=initCentroid(:,features); %projected initial centroid on this features
  
  [clusters,cCentroid]=kmeans(projData,noClusters,'distance','sqEuclidean','start',iCentroid,'emptyaction','drop');  
  
  
  %global centroid calculation
  gCentroid=mean(projData);
  subRes=(projData-repmat(gCentroid,[totTrain,1])).^2; %element wise sub and square %[totPtrn x b] matrix
  SST=sum(sum(subRes)); %first sum all columns, than sum the resltant values
  
  % for pt=1:totPtrns
  %    SST=SST+power((gCentroid-projData(pt,:)),2);
  % end

  %SSW, SSB calculation
  SSB=0;
  for clstrNo=1:noClusters
     totPnt=histc(clusters,clstrNo); %totElement of clstr i
     SSB=SSB+sum(totPnt*power((gCentroid-cCentroid(clstrNo,:)),2));        
  end
  
  SSW=SST-SSB;
  res_kf=SSW/SSB;
end