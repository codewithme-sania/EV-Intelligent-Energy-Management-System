function result = Smart_EMS(batterySOC, solarPower, loadPower)
% Smart EV Energy Management System
% Basic rule-based energy management demonstration.
% NOTE: This reconstructed code has not yet been validated in MATLAB.

% Validate input values
if batterySOC < 0 || batterySOC > 100
error('Battery SOC must be between 0 and 100.');
end

if solarPower < 0 || loadPower < 0
error('Power values must be non-negative.');
end

% Calculate available solar power and remaining demand
solarToLoad = min(solarPower, loadPower);
remainingLoad = loadPower - solarToLoad;
surplusSolar = solarPower - solarToLoad;

% Set battery management thresholds
minSOC = 20;
maxSOC = 90;

batteryAction = 'Idle';
batteryPower = 0;

% Charge from surplus solar energy
if surplusSolar > 0 && batterySOC < maxSOC
batteryAction = 'Charge';
batteryPower = surplusSolar;

% Discharge battery to support remaining load
elseif remainingLoad > 0 && batterySOC > minSOC
batteryAction = 'Discharge';
batteryPower = -remainingLoad;
end

% Return results
result.solarToLoad = solarToLoad;
result.remainingLoad = remainingLoad;
result.surplusSolar = surplusSolar;
result.batteryAction = batteryAction;
result.batteryPower = batteryPower;
result.batterySOC = batterySOC;

end
