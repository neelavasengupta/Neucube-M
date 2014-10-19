function [train_accuracy,weights,test_accuracy] = supervised_learning( output_spike,y, train_percentage,lambda,cycle )
%SUPERVISED_LEARNING Summary of this function goes here
%   Detailed explanation goes here
trials=size(output_spike,3);
num_neurons=size(output_spike,2);
timepoints=size(output_spike,1);
y_perm=randperm(trials);
num_train=round(trials*train_percentage);
%num_test=trials-num_train;

index_train(:,1)=y_perm(1:num_train);
index_test(:,1)=y_perm(num_train+1:end);

train_data=output_spike(:,:,index_train);
train_target=y(index_train);

test_data=output_spike(:,:,index_test);
test_target=y(index_test);

%%tempotron learning
[train_accuracy,weights] = tempotron_training( train_data,train_target, lambda,cycle );
test_accuracy  = tempotron_testing( test_data,test_target,weights );



end

