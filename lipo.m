% LiPo Battery Charge/Discharge Simulation

% Parameters
capacity = 2000; % Battery capacity in mAh (milliampere-hour)
initial_SOC = 50; % Initial State of Charge in percentage (0-100)
charge_C_rate = 1; % Charging rate in C-rate (e.g., 1C means full charge in 1 hour)
discharge_C_rate = 0.5; % Discharging rate in C-rate (e.g., 0.5C means full discharge in 2 hours)
time_step = 1; % Time step in minutes
total_time = 240; % Total simulation time in minutes
charge_efficiency = 0.95; % Charging efficiency (95%)

% Convert capacity from mAh to Ah for calculations
capacity_Ah = capacity / 1000; 

% Initialize SOC
SOC = initial_SOC;

% Initialize time array
time = 0:time_step:total_time;

% Initialize SOC array
SOC_array = zeros(size(time));

% Simulation loop
for i = 1:length(time)
    % Check if charging or discharging
    if mod(time(i), 60) < 30 % Example: charge for 30 minutes every hour
        % Charging
        SOC = SOC + (charge_C_rate * capacity_Ah * (time_step / 60)) * charge_efficiency / capacity_Ah * 100;
    else
        % Discharging
        SOC = SOC - (discharge_C_rate * capacity_Ah * (time_step / 60)) / capacity_Ah * 100;
    end
    
    % Ensure SOC stays within bounds (0-100%)
    SOC = max(0, min(100, SOC));
    
    % Store SOC in array
    SOC_array(i) = SOC;
end

% Plot SOC over time
figure;
plot(time, SOC_array, 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('State of Charge (%)');
title('LiPo Battery Charge/Discharge Simulation');
grid on;

