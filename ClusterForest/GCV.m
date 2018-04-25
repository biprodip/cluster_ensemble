function [f,kf]=GCV()
%input (passed as global variable)
%b : number of samples per selection
%tou_m: max iteration
%output:  
%f: selected feature set 
%kf: cluster quality measure

global b tou_m;

tou=0;
f_tmp=zeros(1,b);         %each turn will return b features

%initialize first set
f=FC();
kf=getKF(f);              %len of f upto where features exists

while 1
  
   f_tmp=FC();          %sample b features
   f_2=union(f,f_tmp);   
   kf2=getKF(f_2);      %get quality of merged set
   
   if kf2<kf
     f=f_2;                %f is updated
     %display('f is Updated');
     kf=kf2
     tou=0;
     %f_2
   else
     tou=tou+1;
   end
      
   if tou>tou_m 
     break;
   end
                   
end  %end while
