
function Pcharge = Smart_EMS(GridPower, SolarPower, SOC, Batt_Temp, P_batt)
% SMART_EMS Reconstructed EV charging power controller.
% Based on the available project screenshots.
% This is a new reconstruction, not the missing original source code.
%
% Inputs:
% GridPower - available grid power (W)
% SolarPower - available solar power (W)
% SOC       - battery state of charge (%)
% Batt_Temp - battery temperature (deg C)
% P_batt    - measured battery power (W)
%
% Output:
% Pcharge   - requested charging power (W)

% Illustrative limits; validate against actual battery specifications.
Pmax = 7400;
SOC_stop = 90;
T_high = 40;
T_resume = 38;

% Default: no charging
Pcharge = 0;

% Validate inputs
if any(~isfinite([GridPower, SolarPower, SOC, Batt_Temp, P_batt]))
    return;
end

% Do not charge if battery limits are reached
if SOC >= SOC_stop || Batt_Temp >= T_high
    return;
end

% Illustrative solar-priority power allocation
availablePower = max(0, SolarPower) + max(0, GridPower);
Pcharge = min(availablePower, Pmax);

% Reduce charging as SOC approaches the stop threshold
if SOC >= 80
    Pcharge = min(Pcharge, Pmax * (SOC_stop - SOC) / 10);
end

% Temperature-based derating
if Batt_Temp > T_resume
    Pcharge = min(Pcharge, Pmax * ...
        max(0, (T_high - Batt_Temp) / (T_high - T_resume)));
end

% Prevent negative power
Pcharge = max(0, Pcharge);

end
