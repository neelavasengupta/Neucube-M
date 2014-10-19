function [output_spike,output_potential,output_neucube_weight] = unsupervised_learning( spike_train, neucube_connection, initial_neucube_weight, refractory_time, threshold_potential, leak_rate, STDP_rate )
%UNSUPERVISED_LEARNING Summary of this function goes here
%   Detailed explanation goes here

% parameters of the unsupervised learning
%refractory_time=4;
%threshold_potential=0.1;
%leak_rate=0.002;
%STDP_rate=0.01;

%average_initial_potential=mean(mean(initial_neucube_weight))

%initial_neucube_weight=initial_neucube_weight(1:size(initial_neucube_weight,2),:);
trials=size(spike_train,3);

output_potential=zeros(size(spike_train,1),size(initial_neucube_weight,2),trials);
output_spike=zeros(size(spike_train,1),size(initial_neucube_weight,2),trials); 
output_neucube_weight=zeros(size(initial_neucube_weight,2),size(initial_neucube_weight,2),size(spike_train,1));

for tr=1:trials
    %disp(tr);
    neucube_weight=initial_neucube_weight(1:size(initial_neucube_weight,2),:);
    input_weight=initial_neucube_weight(size(initial_neucube_weight,2)+1:end,:);
    %indices_of_input_neuron=1:size(initial_neucube_weight,2);
    no_input_neuron=size(initial_neucube_weight,2);
    no_spiking_neuron=size(initial_neucube_weight,2);
    timepoints=size(spike_train,1);
    spike_train_tr=spike_train(:,:,tr);
    total_spike=zeros(1,no_spiking_neuron);
    potential=zeros(1,no_spiking_neuron);
    spike_flag=zeros(1,no_spiking_neuron);
    input_spike_flag=zeros(1,no_input_neuron);
    last_spike_time=zeros(1,no_spiking_neuron);
    refractory=zeros(1,no_spiking_neuron);


    for time=1:timepoints
    %%@ every time point check if a neuron spiked at previous time.If there
    %%was a spike, then update all connections from the neuron with a spike.
    %%Each receiving neuron update its potential by the amount of connection weight after receiving a spike only
    %%if it is not in refractory period
  
        for neuron_i=1:no_spiking_neuron
            if spike_flag(neuron_i)==1
                last_spike_time(neuron_i)=time;
            for neuron_j=1:no_spiking_neuron
                if neucube_connection(neuron_i,neuron_j)==1
                    total_spike(neuron_j)=total_spike(neuron_j)+1;
                    if refractory(neuron_j)==0  
                        potential(neuron_j)=potential(neuron_j)+neucube_weight(neuron_i,neuron_j);
                    end
                end       
            end
            spike_flag(neuron_i)=0;
            end
        end
    
    %%add the potential share to all the neurons from input neuron(if spiked)
    for input_neuron=1:no_input_neuron
        if input_spike_flag(input_neuron)==1
            if refractory(input_neuron)==0
                potential(input_neuron)=potential(input_neuron)+input_weight(input_neuron,input_neuron);
            end
        end
    end
    
    output_potential(time,:,tr)=potential;
    
    %%For every neuron check if the neuron reached the threshold potential.
    %%If the threshold potential is reached reset it to base potential(0) and reset the refratory period to maximum.
    for neuron_j=1:no_spiking_neuron 
        if potential(neuron_j)>threshold_potential %%reset potential, refractory, and spike flag for firing neuron
            potential(neuron_j)=0;
            refractory(neuron_j)=refractory_time;
            spike_flag(neuron_j)=1;
        else %% leak potential and reduce refractory for non firing neurons
            potential(neuron_j)=max(0,(potential(neuron_j)-leak_rate));
            refractory(neuron_j) = max(0, refractory(neuron_j) - 1);
        end        
    end
    
    %% For every neuron in case of spike at this time point update the connection weight of the input neurons according to the STDP rule
    for neuron_j=1:no_spiking_neuron
        if spike_flag(neuron_j)==1
            for neuron_i=1:no_spiking_neuron
                if neucube_connection(neuron_i,neuron_j)==1
                    neucube_weight(neuron_i,neuron_j) = neucube_weight(neuron_i,neuron_j) + STDP_rate / (time - last_spike_time(neuron_j) + 1);
                end
            end
            for input_neuron=1:no_input_neuron
                input_weight(input_neuron,input_neuron)=input_weight(input_neuron,input_neuron)+STDP_rate/(time - last_spike_time(neuron_j) + 1);
            end
        end
    end
    
    output_spike(time,:,tr)=spike_flag;  
    
    input_spike_flag=spike_train_tr(time,:); %% set the input spike train at this time point as the spiking behaviour of input neuron
   if(tr==1)
        output_neucube_weight(:,:,time)=neucube_weight;
   end
    end

%neucube_weight=mean(neucube_weight,2);
%output_neucube_weight(:,:,trials)=neucube_weight;
end

