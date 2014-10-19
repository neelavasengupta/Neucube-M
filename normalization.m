function [ data_norm ] = normalization( data )
%NORMALIZATION 0,1 normalization
%   Detailed explanation goes here
%time=size(data,1);
feature=size(data,2);
trials=size(data,3);
maximum=squeeze(max(data,[],1));
minimum=squeeze(min(data,[],1));
data_norm=zeros(size(data,1),feature,trials);
for i=1:trials
    for j=1:feature
        data_norm(:,j,i)=(data(:,j,i)-minimum(j,i))/(maximum(j,i)-minimum(j,i));
    end
end
end

