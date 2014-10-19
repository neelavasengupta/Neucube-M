function [ output_args ] = calculate_neuron_per_connection( neucube_connection )
for i=1:3662
k(i)=numel(find(neucube_connection(i,:)));
end
bar(k)


end

