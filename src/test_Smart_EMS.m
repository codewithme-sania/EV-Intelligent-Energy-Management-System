
%% Test reconstructed Smart EMS controller
% Run in MATLAB after saving Smart_EMS.m in the same folder.

clear;
clc;

% Test 1: Normal charging conditions
P1 = Smart_EMS(7000, 3000, 50, 30, 5200);

% Test 2: SOC has reached the stop threshold
P2 = Smart_EMS(7000, 3000, 90, 30, 5200);

% Test 3: Battery temperature has reached the limit
P3 = Smart_EMS(7000, 3000, 50, 40, 5200);

% Test 4: Battery is close to the SOC threshold
P4 = Smart_EMS(7000, 3000, 85, 30, 5200);

% Display results
fprintf('Test 1 - Normal charging: %.2f W\n', P1);
fprintf('Test 2 - SOC stop protection: %.2f W\n', P2);
fprintf('Test 3 - Temperature protection: %.2f W\n', P3);
fprintf('Test 4 - High SOC derating: %.2f W\n', P4);

% Basic checks
assert(P1 >= 0 && P1 <= 7400, 'Test 1 failed');
assert(P2 == 0, 'Test 2 failed');
assert(P3 == 0, 'Test 3 failed');
assert(P4 >= 0 && P4 <= 3700, 'Test 4 failed');

fprintf('\nAll basic controller checks passed.\n');
