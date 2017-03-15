clear
clc

Total_time = 10; % simulation time
N          = 20; % lengh of queue
lambda     = 10; % arrival rate
mu         = 6;  % service rate

arr_mean = 1 / lambda; % average arrival time
ser_mean = 1 / mu;     % average service time
arr_num  = round(Total_time * lambda * 2); % max number of customer

% events(1,:) => arrival time
% events(2,:) => service time
% events(3,:) => wait time
% events(4,:) => left time
% events(5,:) => status of the i th customer(1:accept, 0:reject)
% use exponential distribution to generate the arrival interval time
% and accumulate the sum of it to get customer arrival time
events      = [];
events(1,:) = exprnd(arr_mean, 1, arr_num);
events(1,:) = cumsum(events(1,:));

% use exponential distribution to generate the service time
events(2,:) = exprnd(ser_mean, 1, arr_num); 
% count the number of arrival time in simulation time
len_sim     = sum(events(1,:) <= Total_time);

%**********************************************
%                  first customer
%**********************************************
% first costumer no wait
% left time equals arrival time add service time
% member: customers who accept service
events(3,1) = 0;
events(4,1) = events(1,1) + events(2,1); 
events(5,1)  = 1;
member_index = 1;
member       = zeros(0, arr_num);
member(1)    = 1;
member_index = member_index + 1;

%**********************************************
%              2 ~ len_sim customers
%**********************************************
for i = 2:len_sim
    % concurrency number of customers under service
    number = sum(events(4,member) > events(1,i));
    if number >= N+1       % queue full
        events(5,i) = 0;
    else if number == 0    % queue empty
        events(3,i) = 0;   % get service without waiting
        events(4,i) = events(1,i) + events(2,i);
        events(5,i) = 1;
        member(member_index) = i;
        member_index = member_index + 1;
        else               % queue not full and has jobs
        len_mem = length(member);
        % waiting time = former left time - current arrival time
        events(3,i) = events(4, member(len_mem)) - events(1,i);
        % left time = former left time + current service time
        events(4,i) = events(4, member(len_mem)) + events(2,i);    
        events(5,i) = number+1;
        member(member_index) = i;
        member_index = member_index + 1;
        end
    end
end

% the total number of customer who accept service
len_mem = length(member);

%**********************************************
%                  plot
%**********************************************
stairs(0:len_mem, [0 events(1,member)]);
hold on;
stairs(0:len_mem, [0 events(4,member)], '.-r');
legend('arrive time', 'leave time', 'Location', 'northwest');
xlabel('customer no');
ylabel('time');
text(5,10,strcat('customer number:', num2str(len_mem)));
hold off; 

grid on;
figure;
plot(1:len_mem, events(3,member), 'r-*', 1:len_mem, events(2,member)+events(3,member), 'k-');
legend('wait time', 'dwell time', 'Location', 'northwest');
xlabel('customer no');
ylabel('time');
grid on;