function [output_weight] = deSNN_training( output_spike, modulus, drift)
%DESNN_TRAINING Summary of this function goes here
%   Detailed explanation goes here

%%hyperparameters
%modulus=0.6;
%drift=0.05;


trials=size(output_spike,3);
num_neurons=size(output_spike,2);
timepoints=size(output_spike,1);

output_potential=zeros(1,trials); %% create a neuron for each trial
output_spike_threshold=zeros(1,trials);
output_weight=zeros(trials,num_neurons);
output_class_sn=ones(1,trials)*(-1);
output_order=ones(trials,num_neurons)*(-100);

for tr=1:trials
    order_sn=0;
    order=[];
    for time=1:timepoints
        for neuron=1:num_neurons
            if output_spike(time,neuron,tr)==1 %%if the neuron spikes at this time 
                if output_order(tr,neuron)<0 %% this is the first spike
                    output_order(tr,neuron)=order_sn;                 
                    output_weight(tr,neuron)=modulus^order_sn;
                    order(end+1)=neuron;
                else
                    output_weight(tr,neuron)=output_weight(tr,neuron)+drift;
                end
                output_potential(1,tr)= output_potential(1,tr)+output_weight(tr,neuron);
            else
                output_weight(tr,neuron)=output_weight(tr,neuron)-drift;
            end
            order_sn=order_sn+1;
        end
    end
end
end

