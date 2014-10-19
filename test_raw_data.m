function [ result ] = test_raw_data( encoded_data,class_labels )
%TEST_RAW_DATA Summary of this function goes here
%   Detailed explanation goes here
train_percentage=0.5;
input_spike=encoded_data;
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

end

