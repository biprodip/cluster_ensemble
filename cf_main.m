clc
clear all

addpath 'ClusterForest';
global totFeature decisionCol totTrain trainData trainClass uClasses totTest noClusters q b tou_m;

totTrain=351; 
totTest=0;  

filename='ionosphere.txt'; 
fid = fopen(filename);
 tmpTrainData = textscan(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%s'); %*********
fclose(fid);

[~,decisionCol]=size(tmpTrainData); % last column is defined as label
totFeature=decisionCol-1;

for feature=1:totFeature
  trainData(:,feature)=tmpTrainData{feature}(:,1);
end

for sample=1:totTrain
  if strcmp(tmpTrainData{decisionCol}(sample,1),'b')
    trainClass(sample,1)=2; %negative
  else
    trainClass(sample,1)=1;
  end
end



noClusters=length(unique(trainClass(:)));
b=4;  %samples taken per turn for quality measurement
q=5;  %no of turn,sample selection and merge is carried out
tou_m=50;
uClasses=unique(trainClass); %unique classes (data(:,decisionCol));
[features,kf]=GCV();

[clusters,cCentroid,sumD]=kmeans(trainData,noClusters,'distance','sqEuclidean','emptyaction','drop');  
[clustersCF,cCentroidCF,sumDCF]=kmeans(trainData(:,features),noClusters,'distance','sqEuclidean','emptyaction','drop');  
bar([sumD sumDCF])
legend('All eatures','CF')
xlabel('Cluster number')
ylabel('Intracluster sum of points to centroid')