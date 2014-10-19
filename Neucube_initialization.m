function [neucube_connection, neucube_weight] = Neucube_initialization( spiking_neuron_coordinates,similarity_threshold )
%NEUCUBE_INITIALIZATION Summary of this function goes here
%neucube_weight,neucube_connection, similarity
%   Initialize the structure of the directed graph,controlled by similarity
%   threshold parameter. Associate weights with the directed edges
%   proportional to the distance between the neuron pairs attached to the edge 
%neucube_weight = sign(rand(no_spiking_neuron)-0.2).*rand(no_spiking_neuron).*similarity_matrix
no_spiking_neuron=size(spiking_neuron_coordinates,1);

distance=L2_distance(spiking_neuron_coordinates', spiking_neuron_coordinates');  %distance between neurons
similarity=1./distance;
similarity(isnan(similarity))=0;
similarity(isinf(similarity))=0;
%max(max(similarity))
%min(min(similarity))
neucube_weight=similarity;

% for k=1:size(input_mapping,1)
%     coord=input_mapping(k,:);
%     
%     idx=find(ismember(spiking_neuron_coordinates,coord,'rows'));
% 
%     nn(k)=idx(1);    
% end
% indices_of_input_neuron=nn;
% LL=false(no_spiking_neuron,1);
% LL(indices_of_input_neuron)=true;
% 
 neucube_connection = ones(no_spiking_neuron);
 choice=randi(2,no_spiking_neuron)-1;
% 
for i =1:no_spiking_neuron
    for j = 1:no_spiking_neuron
        if similarity(i,j)<similarity_threshold
            neucube_connection(i,j)=0;
        elseif neucube_connection(i,j)==1 && neucube_connection(j,i)==1
                if choice(i,j) == 1
                    neucube_connection(i,j) = 0;
                else
                    neucube_connection(j,i)=0;            
                end
        
        end
         neucube_weight(i,j)=neucube_connection(i,j)*neucube_weight(i,j); 
    end
end
end
% 
