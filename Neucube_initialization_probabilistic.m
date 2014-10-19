function [neucube_connection, neucube_weight] = Neucube_initialization_probabilistic( spiking_neuron_coordinates,similarity_threshold)
%NEUCUBE_INITIALIZATION_PROBABILISTIC Summary of this function goes here
%   Detailed explanation goes here
no_spiking_neuron=size(spiking_neuron_coordinates,1);

distance=L2_distance(spiking_neuron_coordinates', spiking_neuron_coordinates');  %distance between neurons
similarity=1./distance;
similarity(isnan(similarity))=0;
similarity(isinf(similarity))=0;
%max(max(similarity))
%min(min(similarity))
neucube_weight=ones(size(spiking_neuron_coordinates,1))*0.1;%similarity;
neucube_connection = ones(no_spiking_neuron);
choice=randi(2,no_spiking_neuron)-1;
 
for i =1:no_spiking_neuron
   % disp(i);
    for j = 1:no_spiking_neuron
        if similarity(i,j)<similarity_threshold
            neucube_connection(i,j)=0;
        else
            prob=normpdf(similarity(i,j),0,1);
            if prob>=rand        
                neucube_connection(i,j)=0;
            elseif neucube_connection(i,j)==1 && neucube_connection(j,i)==1
                if choice(i,j) == 1
                    neucube_connection(i,j) = 0;
                else
                    neucube_connection(j,i)=0;            
                end
            end
        end
        neucube_weight(i,j)=neucube_connection(i,j)*neucube_weight(i,j);
    end
    
end
v=ones(1,size(neucube_connection,1));
w=rand(1,size(neucube_connection,1));
input_connection=diag(v);
neucube_connection=vertcat(neucube_connection,input_connection);
neucube_weight=vertcat(neucube_weight,diag(w));

