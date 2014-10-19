function [ output_args ] = show_connection( neucube_connection,neucube_weight,spiking_neuron_coordinates)
%SHOW_CONNECTION Summary of this function goes here
%   Detailed explanation goes here
count=0;
%neucube_weight=rand(3662);
k=1;
for i=1:3662
    for j=1:3662
        if(neucube_weight(i,j)~=0)
            pqr(k)=neucube_weight(i,j);
            k=k+1;
        end
    end
end
min_weight=min(min(pqr))
max_weight=max(max(pqr))
interval1=min_weight+(max_weight-min_weight)/5;
interval2=interval1+(max_weight-min_weight)/5;
interval3=interval2+(max_weight-min_weight)/5;
interval4=interval3+(max_weight-min_weight)/5;
nn=size(neucube_connection,2);
for i=1:nn
    for j=1:nn
        if(neucube_connection(i,j)==1)
           count=count+1;
           point1= spiking_neuron_coordinates(i,:);
           point2= spiking_neuron_coordinates(j,:);
           x(:,count)=[point1(1,1) point2(1,1)];
           y(:,count)=[point1(1,2) point2(1,2)];
           z(:,count)=[point1(1,3) point2(1,3)];
          
           if(neucube_weight(i,j)<interval1)   
               colour(count,:)=[0 0 1];%%blue
           elseif(neucube_weight(i,j)>=interval1 && neucube_weight(i,j)<interval2)
               colour(count,:)=[1 1 0];%%cyan
           elseif(neucube_weight(i,j)>=interval2 && neucube_weight(i,j)<interval3)
               colour(count,:)=[1 1 0];%%yellow
           elseif(neucube_weight(i,j)>=interval3 && neucube_weight(i,j)<interval4)
               colour(count,:)=[0 1 0];%%green
           else
               colour(count,:)=[1 0 0];%%red
           end
        end
    end
end

co = get(gca,'ColorOrder'); % Initial
% Change to new colors.

set(gca, 'ColorOrder', colour, 'NextPlot', 'replacechildren');
view([0 0]);
%co = get(gca,'ColorOrder'); % Verify it changed
plot3(x,y,z);
xlabel('x');
ylabel('y');
zlabel('z');
box on;
end

