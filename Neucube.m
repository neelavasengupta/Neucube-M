function [unsupervised_spike,unsupervised_potential,unsupervised_weight,result] = Neucube( spike_train,class_labels,neucube_connection, initial_neucube_weight, input_mapping, refractory_time, threshold_potential, leak_rate, STDP_rate)
%NEUCUBE Summary of this function goes here
%   Detailed explanation goes here

%Hyperparameters%%%%%%%%%%%%%%%%%%
train_percentage=0.5;

%,unsupervised_spike,unsupervised_potential,train_accuracy,weights,test_accuracy
%%Neucube initialization hyperparameter
%controls the sparseness of reservoir connection establishment. Smaller value leads to more dense connection 
%similarity_threshold=0.01;

%%Neucube spatial distribution generator hyperparameter
%random x,y,z coordinates of the spiking neuron. 
%TODO:Change it to one hyperparameter of total no of spiking neuron
% no_x_coordinate=3;
% no_y_coordinate=3;
% no_z_coordinate=3;

% 
% normalized_data=normalization(raw_data);   %normalize the data
% disp('encoding data...');
% spike_train=data_encoding(normalized_data); %encode the normalized data in spike trains
% disp('generating coordinates...');
% spiking_neuron_coordinates=generate_neuron_coordinate(no_x_coordinate,no_y_coordinate,no_z_coordinate,input_mapping);% randomly generate hidden neuron coordinates.
% disp('Initializing neucube...');
%[initial_neucube_weight,neucube_connection, similarity]=Neucube_initialization(spiking_neuron_coordinates,input_mapping,similarity_threshold); %initialize the neucube
% initial_neucube_weight(isnan(initial_neucube_weight))=0;

%unsupervised learning 
disp('LSM unsupervised learning...');
tic;
[unsupervised_spike,unsupervised_potential,unsupervised_weight]=unsupervised_learning(spike_train,neucube_connection,initial_neucube_weight, refractory_time, threshold_potential, leak_rate, STDP_rate);


%%%%pattern recognition and evaluation
disp('pattern recognition....');
input_spike=unsupervised_spike;
lambda=0.005;

for i=1:20 
    for k=1:10 
        [train_accuracy,weights,test_accuracy]=supervised_learning( input_spike,class_labels, train_percentage,lambda,4 );
        tr(k)=test_accuracy;
        %test_accuracy
    end
    rs=mean(tr);
    sd=std(tr);
    result(i,1)=lambda;
    result(i,2)=rs;
    result(i,3)=sd;
    %rs
    %sd
    lambda=lambda+0.005;
end
toc;
end

