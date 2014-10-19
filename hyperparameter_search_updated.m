function [] = hyperparameter_search_updated( class_labels, spike_train, neucube_connection, initial_neucube_weight,neuinput,refactory_time_min,refactory_step, refactory_time_max,threshold_min,threshold_step, threshold_max, leak_min, leak_step, leak_max, STDP_min,STDP_step,STDP_max )
%HYPERPARAMETER_SEARCH Summary of this function goes here
%   Detailed explanation goes here
fid=fopen('experiment0.5.txt','a');
% refactory_time_min=0;
% refactory_time_max=0;
% refactory_step=0;
if refactory_step~=0
    refactory_increment=(refactory_time_max-refactory_time_min)/refactory_step;
    for i=1:refactory_step
        ref(i)=round(refactory_time_min+(i-1)*refactory_increment);
        %refactory_time_min=ref(i);
        %ref(i)=round(ref(i));
    end
else
    ref(1)=round(refactory_time_min);
end


% threshold_min=0.01;
% threshold_max=0.7;
% threshold_step=10;
if threshold_step~=0
    threshold_increment=(threshold_max-threshold_min)/threshold_step;
    for i=1:threshold_step
        thresh(i)=threshold_min+(i-1)*threshold_increment;
        %threshold_min=thresh(i);
    end
else
    thresh(1)=threshold_min;
end


% STDP_min=0.01;
% STDP_max=0.7;
% STDP_step=10;
if STDP_step~=0
    STDP_increment=(STDP_max-STDP_min)/STDP_step;
    for i=1:STDP_step
        STDP(i)=STDP_min+(i-1)*STDP_increment;
        %STDP_min=STDP(i);
    end
else
    STDP(1)=STDP_min;
end

% leak_min=0.01;
% leak_max=0.7;
% leak_step=10;
if leak_step~=0
    leak_increment=(leak_max-leak_min)/leak_step;
    for i=1:leak_step
        leak(i)=leak_min+(i-1)*leak_increment;
        %leak_min=leak(i);
    end
else
    leak(1)=leak_min;
end

% % mod_min=0.01;
% % mod_max=0.7;
% % mod_step=10;
% if lrate_step~=0
%     lrate_increment=(lrate_max-lrate_min)/lrate_step;
%     for i=1:lrate_step
%         lrate(i)=lrate_min+(i-1)*lrate_increment;
%         %mod_min=mod(i);
%     end
% else
%     lrate(1)=lrate_min;
% end
% 
% % drift_min=0.01;
% % drift_max=0.7;
% % drift_step=10;
% if cycle_step~=0
%     cycle_increment=(cycle_max-cycle_min)/cycle_step;
%     for i=1:cycle_step
%         cycle(i)=round(cycle_min+(i-1)*cycle_increment);
%         %drift_min=drift(i);
%     end
% else
%     cycle(1)=cycle_min;
% end

        for k=1:numel(leak)
            for l=1:numel(STDP)
                for m=1:numel(ref)
                    for n=1:numel(thresh)
                        
                        [unsupervised_spike,unsupervised_potential,unsupervised_weight,result] = Neucube( spike_train,class_labels,neucube_connection, initial_neucube_weight, neuinput, ref(m), thresh(n), leak(k), STDP(l));
                        
                        [a,b]=max(result(:,2));
                        best_accuracy=a(1);
                        lambda=result(b(1),1);
                        sd=result(b(1),3);
                        fprintf(fid, '\nhyperparam: %f %d %f %f %f \t test accuracy: %f sd: %f ', thresh(n),ref(m), leak(k), STDP(l),lambda ,best_accuracy, sd);
                        sprintf('\nhyperparam: %f %d %f %f %f \t test accuracy: %f sd: %f ', thresh(n),ref(m), leak(k), STDP(l), lambda,best_accuracy,sd)
                    end
                end
            end
        end
        

fclose(fid);





end

