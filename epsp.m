function [psp] = epsp( time_diff)
%NEURON_POTENTIAL Summary of this function goes here
%   Post synaptic potential function, controled by parameters decay_rate
%   presynaptic_node_firing_time and delay
%time=current_time-spike_time;
%tau=1;

if time_diff==0 
    psp=1;
else
    psp=0;
end
end

