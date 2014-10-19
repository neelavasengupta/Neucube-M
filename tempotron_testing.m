function [ test_accuracy ] = tempotron_testing( test_spike,y,weights )
%TEMPOTRON_TESTING Summary of this function goes here
%   Detailed explanation goes here
threshold=0;
trials=size(test_spike,3);
num_neurons=size(test_spike,2);
timepoints=size(test_spike,1);
        sum_wrong_pred=0;
        for tr=1:trials
            potential=zeros(timepoints,1);
            spike=test_spike(:,:,tr);
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
                end
            else
                if(potential_max>threshold) %%wrong prediction. spikes
                    sum_wrong_pred=sum_wrong_pred+1;     
                end
            end  
        end
        test_accuracy=(1-(sum_wrong_pred/trials))*100;


end

