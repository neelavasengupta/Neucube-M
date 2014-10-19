function [spike_train ] = data_encoding( data )
%DATA_ENCODING Summary of this function goes here
%   Detailed explanation goes here
no_trials=size(data,3);
%no_timepoints=size(data,1);
no_features=size(data,2);
data_diff=diff(data,1,1);
variable_threshold=mean(mean(data_diff,1),3);
spike_train=zeros(size(data_diff,1),no_features,no_trials);
for trial=1:no_trials
    for feature=1:no_features
        for time=1:size(data_diff,1)
            if(data_diff(time,feature,trial)>variable_threshold(feature))
                spike_train(time,feature,trial)=1;
            else
                spike_train(time,feature,trial)=0;
            end
        end
    end
end











end

