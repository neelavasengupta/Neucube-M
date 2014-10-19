function [train_accuracy,weights] = tempotron_training( output_spike,y, lambda,training_cycle )
%TEMPOTRON_TRAINING Summary of this function goes here
%   Detailed explanation goes here
threshold=1;
%lambda=0.01; %%learning rate


trials=size(output_spike,3);
num_neurons=size(output_spike,2);
timepoints=size(output_spike,1);
weights=rand(num_neurons,1);
for cycle=1:training_cycle
    sum_wrong_pred=0;
        for tr=1:trials
            potential=zeros(timepoints,1);
            spike=output_spike(:,:,tr);
            for time=1:timepoints
                for neuron_i=1:num_neurons
                    if(spike(time,neuron_i)==1)
                        potential(time)=potential(time)+weights(neuron_i,1);
                    end 
                end
            end
            potential_max=max(potential);
       
            if(y(tr)==1)
                if(potential_max<=threshold) %%wrong prediction. does not spike
                    sum_wrong_pred=sum_wrong_pred+1;
                    for i=1:num_neurons
                        weights(i,1)=weights(i,1)+lambda;
                    end
                end
            else
                if(potential_max>threshold) %%wrong prediction. spikes
                    sum_wrong_pred=sum_wrong_pred+1;
                    for i=1:num_neurons 
                        weights(i,1)=weights(i,1)-lambda;
                    end      
                end
            end
            %sum_wrong_pred
            %train_accuracy=(1-(sum_wrong_pred/trials))*100;
        end
        train_accuracy=(1-(sum_wrong_pred/trials))*100 ;     
end
end

