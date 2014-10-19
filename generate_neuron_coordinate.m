function [neuron_location] = generate_neuron_coordinate( no_x_coord,no_ycoord,no_z_coord,input_mapping )
%GENERATE_NEURON_COORDINATE Summary of this function goes here
%   Detailed explanation goes here
total_neurons=no_x_coord*no_ycoord*no_z_coord+size(input_mapping,2);
random_neurons=no_x_coord*no_ycoord*no_z_coord;
xmax=max(input_mapping(:,1));
xmin=min(input_mapping(:,1));
ymax=max(input_mapping(:,2));
ymin=min(input_mapping(:,2));
zmax=max(input_mapping(:,3));
zmin=min(input_mapping(:,3));
coordinate=zeros(random_neurons,3);
for i=1:random_neurons
    
        coordinate(i,1)=randi([xmin,xmax]);
        coordinate(i,2)=randi([ymin,ymax]);
        coordinate(i,3)=randi([zmin,zmax]);
    while(ismember(input_mapping, coordinate(i,:), 'rows')~=0)
        coordinate(i,1)=randi([xmin,xmax]);
        coordinate(i,2)=randi([ymin,ymax]);
        coordinate(i,3)=randi([zmin,zmax]);
        
    end
end
neuron_location=vertcat(input_mapping,coordinate);
end

