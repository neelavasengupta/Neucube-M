function [unsupervised_spike,unsupervised_potential,unsupervised_weight] = learning_best_param( class_labels, spike_train, neucube_connection, initial_neucube_weight,input_mapping, refractory_time, threshold_potential, leak_rate, STDP_rate,learning_rate,training_cycle)
%LEARNING Summary of this function goes here
%   Detailed explanation goes here

%%Neucube unsupervised learning hyperparameter
%controls the spiking behaviour of the spiking neurons
% refractory_time=4; %Controls the saturation period of a neuron after a spike fires. All input spikes during a refractory period is ignored.(Ignores the consecutive high changes in input)
% threshold_potential=0.1; %Controls the spiking potential. Dependent on input connection density and connection strength. 
% leak_rate=0.002; %Leak rate controls the leaking behaviour of the spiking neuron during the time the neuron is accumulating the potential.(undercompensates for
% %%Noise in the incoming spike ??)
% STDP_rate=0.01; %% Controls the change in the input connection weight when a neuron fires. 

%%Neucube supervised learning hyperparameter
train_fold=10;
%modulus=0.6;
%drift=0.05;


%sprintf('unsupervised learning......')
[unsupervised_spike,unsupervised_potential,unsupervised_weight]=unsupervised_learning(spike_train,neucube_connection,initial_neucube_weight,size(input_mapping,1), refractory_time, threshold_potential, leak_rate, STDP_rate);

%%Tempotron Learning
% input_spike=unsupervised_spike(:,size(input_mapping,1)+1:end,:);
% [training_accuracy,test_accuracy,weights]=tempotron_training(input_spike,class_labels,train_fold,learning_rate,training_cycle);
% %fprintf(fid, '\nhyperparam: %f %d %f %f %f %d\t test accuracy: %f ', threshold_potential,refractory_time, leak_rate, STDP_rate, learning_rate, training_cycle,test_accuracy);
% sprintf('\nhyperparam: %f %d %f %f %f %d\t test accuracy: %f ', threshold_potential,refractory_time, leak_rate, STDP_rate, learning_rate, training_cycle,test_accuracy)



end

