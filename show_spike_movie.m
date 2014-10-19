function [ ] = show_spike_movie( neucube_connection,spike,spiking_neuron_coordinates )
%SHOW_SPIKE_MOVIE Summary of this function goes here
%   Detailed explanation goes here
for k=1:size(spike,1)
    for i=1:size(spike,2)
        if(spike(k,i)==1)
            colour(k,i,:)=[1 0 0];
        else
            colour(k,i,:)=[1 1 0];
        end
    end
end

for i=1:size(spike,1)
    view(3);
   %set(gca, 'ColorOrder', squeeze(colour(i,:,:)), 'NextPlot', 'replacechildren'); 
   scatter3(spiking_neuron_coordinates(:,1),spiking_neuron_coordinates(:,2),spiking_neuron_coordinates(:,3),10,squeeze(colour(i,:,:)),'fill');
   pause(0.2);
   xlabel('x');
   ylabel('y');
   zlabel('z');

end

end

