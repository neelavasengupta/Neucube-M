function [ spike_train,initial_neucube_weight,neucube_connection,spiking_neuron_coordinates ] = structure_generation( raw_data,input_mapping,similarity_threshold )
%STRUCTURE_GENERATION Summary of this function goes here
%   Detailed explanation goes here

%Hyperparameters%%%%%%%%%%%%%%%%%%

%%Neucube initialization hyperparameter
%controls the sparseness of reservoir connection establishment. Smaller value leads to more dense connection 
%similarity_threshold=0.01;

%%Neucube spatial distribution generator hyperparameter
%random x,y,z coordinates of the spiking neuron. 
%TODO:Change it to one hyperparameter of total no of spiking neuron
no_x_coordinate=5;
no_y_coordinate=5;
no_z_coordinate=5;


normalized_data=normalization(raw_data);   %normalize the data
spike_train=data_encoding(normalized_data); %encode the normalized data in spike trains
spiking_neuron_coordinates=generate_neuron_coordinate(no_x_coordinate,no_y_coordinate,no_z_coordinate,input_mapping);% randomly generate hidden neuron coordinates.

[initial_neucube_weight,neucube_connection, similarity]=Neucube_initialization(spiking_neuron_coordinates,input_mapping,similarity_threshold); %initialize the neucube
initial_neucube_weight(isnan(initial_neucube_weight))=0;


end

