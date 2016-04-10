%% Superior Enhancing Cost Calculator
clc
clear

%% Reset same random number arrays everytime program runs
rng('shuffle')

%% Defining success rate and cost
base_rate = [50,50,45,40,40,40,40,40,40,37.5,35,35,25,15,5];
aee_rate = [20,20,20,20,20,20,20,10,10,10,10,10,10,10,10];
total_rate = (base_rate + aee_rate)./100;
fever_rate = [100,100,100,100,100,100,100,100,100,95,90,90,70,50,30]./100;
mesos_cost = 11.2; % 11.2M mesos
nx_cost = 1.12; % 1.12M NX
fever_nx = [0,0,0,0,0,0.224,0.224,2.8,2.8,2.8,2.8,2.8,2.8,2.8,0];   % In terms of millions

%% Helper list
% p1 = success rate; p2 = fail no boom rate; p3 = fail and boom rate
% a1 = p1; a2 = p1 + p2

% Non-fever time rate
suc_rate = [0.7 0.7 0.65 0.6 0.6 0.6 0.6 0.5 0.5 0.475 0.45 0.45 0.35 0.25 0.15];
failboom_rate = [0 0 0 0 0 0 0 0.035 0.07 0.11025 0.154 0.1925 0.273 0.3675 0.476];
pool_rate = suc_rate + failboom_rate;

% Fever time rate
fev_suc_rate = [1, 1, 1, 1, 1, 1, 1, 1, 1, 0.95, 0.9, 0.9, 0.7, 0.5, 0.3];
fev_failboom_rate = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0105, 0.028, 0.035, 0.126, 0.245, 0.392];
fev_pool_rate = fev_suc_rate + fev_failboom_rate;

%% Notes:
% i) No drop in star upon failing until 6* -> 7*
% ii) No destruction upon failing until 7* -> 8*
% iii) No failing when using fever time until 9* -> 10*


%% Initialization of variables
star_desired = 15;
iteration = input('Insert the number of iterations you"d like to run: ');
meso_req = zeros(1, iteration);
nx_req = zeros(1, iteration);
boom_count = zeros(1, iteration);


%% Simulation starts
tic
for index = 1:iteration
    
    %% Reset variables
    total_mesos = 0;
    total_nx = 0;
    star = 0;
    fever = 0;
    boom = 0;
    
    while star ~= star_desired
        
        %% Enhancing from 0* -> 1*
        if star == 0
            total_mesos = total_mesos + mesos_cost;
            total_nx = total_nx + nx_cost;
            
            if rand < suc_rate(1)
                star = star + 1;
            end
            
        end
        
        %% Enhancing from 1* -> 2*
        if star == 1
            total_mesos = total_mesos + mesos_cost;
            total_nx = total_nx + nx_cost;
            
            if rand < suc_rate(2)
                star = star + 1;
            end
            
        end
        
        %% Enhancing from 2* -> 3*
        if star == 2
            total_mesos = total_mesos + mesos_cost;
            total_nx = total_nx + nx_cost;
            
            if rand < suc_rate(3)
                star = star + 1;
            end
            
        end
        
        %% Enhancing from 3* -> 4*
        if star == 3
            total_mesos = total_mesos + mesos_cost;
            total_nx = total_nx + nx_cost;
            
            if rand < suc_rate(4)
                star = star + 1;
            end
            
        end
        
        %% Enhancing from 4* -> 5*
        if star == 4
            total_mesos = total_mesos + mesos_cost;
            total_nx = total_nx + nx_cost;
            
            if rand < suc_rate(5)
                star = star + 1;
            end
            
        end
        
        %% Enhancing from 5* -> 6*
        if star == 5
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                if rand < suc_rate(6)
                    star = star + 1;
                end
                
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(6);
                star = star + 1;
            end
        end
        
        %% Enhancing from 6* -> 7*
        if star == 6
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                if rand < suc_rate(7)
                    star = star + 1;
                else
                    star = star - 1;
                    fever = 1; % fever time!
                    continue
                end
                
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(7);
                star = star + 1;
            end
        end
        
        %% Enhancing from 7* -> 8*
        if star == 7
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(8)    % success
                    star = star + 1;
                elseif temp < pool_rate(8)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;   % fever time!
                    continue
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(8);
                star = star + 1;
            end
        end
        
        %% Enhancing from 8* -> 9*
        if star == 8
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(9)    % success
                    star = star + 1;
                elseif temp < pool_rate(9)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                    continue
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(9);
                star = star + 1;
            end
        end
        
        %% Enhancing from 9* -> 10*
        if star == 9
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(10)    % success
                    star = star + 1;
                elseif temp < pool_rate(10)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                    continue
                end
                % no fever time in 9 -> 10 ee
            end
        end
        
        %% Enhancing from 10* -> 11*
        if star == 10
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(11)    % success
                    star = star + 1;
                elseif temp < pool_rate(11)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    continue% no fever time since no drop in star
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(11);
                
                temp = rand;
                if temp < fev_suc_rate(11)  % success
                    star = star + 1;
                elseif temp < fev_pool_rate(11) % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    continue% no fever time since no drop in star
                end
                
            end
        end
        
        %% Enhancing from 11* -> 12*
        if star == 11
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(12)    % success
                    star = star + 1;
                elseif temp < pool_rate(12)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                    continue
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(12);
                
                temp = rand;
                if temp < fev_suc_rate(12)  % success
                    star = star + 1;
                elseif temp < fev_pool_rate(12) % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1; % fever time again when fail and no boom during fever time
                    continue
                end
                
            end
        end
        
        %% Enhancing from 12* -> 13*
        if star == 12
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(13)    % success
                    star = star + 1;
                elseif temp < pool_rate(13)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                    continue
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(13);
                
                temp = rand;
                if temp < fev_suc_rate(13)  % success
                    star = star + 1;
                elseif temp < fev_pool_rate(13) % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1; % fever time again when fail and no boom during fever time
                    continue
                end
                
            end
        end
        
        %% Enhancing from 13* -> 14*
        if star == 13
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(14)    % success
                    star = star + 1;
                elseif temp < pool_rate(14)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                    continue
                end
            else
                fever = 0; % reset fever time
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + fever_nx(14);
                
                temp = rand;
                if temp < fev_suc_rate(14)  % success
                    star = star + 1;
                elseif temp < fev_pool_rate(14) % fail and boom
                    star = 0;
                    boom = boom + 1;
                    continue
                else % fail no boom
                    star = star - 1;
                    fever = 1; % fever time again when fail and no boom during fever time
                    continue
                end
                
            end
        end
        
        %% Enhancing from 14* -> 15*
        if star == 14
            if fever == 0
                total_mesos = total_mesos + mesos_cost;
                total_nx = total_nx + nx_cost;
                
                temp = rand;
                if temp < suc_rate(15)    % success
                    star = star + 1;
                    meso_req(index) = total_mesos;
                    nx_req(index) = total_nx;
                    boom_count(index) = boom;
                elseif temp < pool_rate(15)   % fail and boom
                    star = 0;
                    boom = boom + 1;
                else % fail no boom
                    star = star - 1;
                    fever = 1;
                end
                
            end
        end
        
    end
end
toc % measure runtime of simulation

%% Statistics Output
fprintf('\n\nResults:\nTo enhance superior equip from 0* to %d*, in %d iterations:\nAverage mesos cost: %fM\nAverage nx cost: %fM\nRounded average boom count: %d times\n', star_desired, iteration, mean(meso_req), mean(nx_req), round(mean(boom_count)))
