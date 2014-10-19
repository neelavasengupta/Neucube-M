function [] = show_connection_movie( neucube_connection,weight,spiking_neuron_coordinates )
%SHOW_CONNECTION_MOVIE Summary of this function goes here
%   Detailed explanation goes here
min_weight=min(min(min(weight)));
max_weight=max(max(max(weight)));
interval1=min_weight+(max_weight-min_weight)/5;
interval2=interval1+(max_weight-min_weight)/5;
interval3=interval2+(max_weight-min_weight)/5;
interval4=interval3+(max_weight-min_weight)/5;
disp('please wait, creating colours......');
for time=1:size(weight,3)
    time
count=0;
neucube_weight=squeeze(weight(:,:,time));
nn=size(neucube_connection,2);
for i=1:nn
    for j=1:nn
        if(neucube_connection(i,j)==1)
           count=count+1;
           point1= spiking_neuron_coordinates(i,:);
           point2= spiking_neuron_coordinates(j,:);
           x(time,:,count)=[point1(1,1) point2(1,1)];
           y(time,:,count)=[point1(1,2) point2(1,2)];
           z(time,:,count)=[point1(1,3) point2(1,3)];
          
           if(neucube_weight(i,j)<interval1)   
               colour(time,count,:)=[0 0 1];%%blue
           elseif(neucube_weight(i,j)>=interval1 && neucube_weight(i,j)<interval2)
               colour(time,count,:)=[0 1 1];%%cyan
           elseif(neucube_weight(i,j)>=interval2 && neucube_weight(i,j)<interval3)
               colour(time,count,:)=[1 1 0];%%yellow
           elseif(neucube_weight(i,j)>=interval3 && neucube_weight(i,j)<interval4)
               colour(time,count,:)=[0 1 0];%%green
           else
               colour(time,count,:)=[1 0 0];%%red
           end
        end
    end
end
end
disp('plotting....');
k=1;
for i=110:159
    view(3);
   set(gca, 'ColorOrder', squeeze(colour(i,:,:)), 'NextPlot', 'replacechildren'); 
   %plot3(squeeze(x(i,:,:)),squeeze(y(i,:,:)),squeeze(z(i,:,:)));
   %pause(0.2);
   plot3(squeeze(x(i,:,:)),squeeze(y(i,:,:)),squeeze(z(i,:,:)))
   xlabel('x');
   ylabel('y');
   zlabel('z');
   F(k)=getframe();
   k=k+1;

end
%movie(F);
movie2avi(F, 'connectionmovie.avi','fps',10);
end
