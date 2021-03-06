clear
clc

SimuTime   = 10; % simulation time
N          = 20; % lengh of queue
lambda     = 10; % arrival rate
mu         = 6;  % service rate

arr_mean = 1 / lambda; % average arrival time
ser_mean = 1 / mu;     % average service time
arr_max  = round(SimuTime * lambda * 2); % max number of customer

% requests(1,:) => arrival time
% requests(2,:) => service time
% requests(3,:) => wait time
% requests(4,:) => left time
% requests(5,:) => status of the i th customer(1:accept, 0:reject)
% use exponential distribution to generate the arrival interval time
% and accumulate the sum of it to get customer arrival time
requests      = [];
requests(1,:) = exprnd(arr_mean, 1, arr_max);
requests(1,:) = cumsum(requests(1,:));

% use exponential distribution to generate the service time
requests(2,:) = exprnd(ser_mean, 1, arr_max); 
% count the number of arrival time in simulation time
requestNum    = sum(requests(1,:) <= SimuTime);

%**********************************************
%                  first customer
%**********************************************
% first costumer no wait
% left time equals arrival time add service time
% member: customers who accept service
requests(3,1) = 0;
requests(4,1) = requests(1,1) + requests(2,1); 
requests(5,1) = 1;

acceptRequestCount         = 1;
rejectedRequestCount       = 0;
member                     = zeros(0, arr_max);
member(acceptRequestCount) = 1;


%**********************************************
%              2 ~ len_sim customers
%**********************************************
for i = 2:requestNum
    % concurrency number of customers under service
    number = sum(requests(4,member) > requests(1,i));
    if number >= N+1         % queue full, rejecte
        requests(5,i) = 0;
        rejectedRequestCount = rejectedRequestCount + 1;
        continue
    end
    
    if number == 0           % queue empty
        requests(3,i) = 0;   % get service without waiting
        requests(4,i) = requests(1,i) + requests(2,i);
        requests(5,i) = 1;
        acceptRequestCount = acceptRequestCount + 1;
        member(acceptRequestCount) = i;
        splitJobs();
    else                     % queue not full and has jobs
        len_mem = length(member);
        % waiting time = former left time - current arrival time
        requests(3,i) = requests(4, member(len_mem)) - requests(1,i);
        % left time = former left time + current service time
        requests(4,i) = requests(4, member(len_mem)) + requests(2,i);    
        requests(5,i) = number+1;
        acceptRequestCount = acceptRequestCount + 1;  
        member(acceptRequestCount) = i;
    end
end

requestNum
acceptRequestCount
rejectedRequestCount





