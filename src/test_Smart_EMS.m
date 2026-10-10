% Basic tests for Smart_EMS.m
% Run only after Smart_EMS.m has been saved in the same folder.

clear;
clc;

% Test 1: Solar power exactly meets the load
r1 = Smart_EMS(50, 100, 100);
assert(r1.solarToLoad == 100);
assert(r1.remainingLoad == 0);
assert(strcmp(r1.batteryAction, 'Idle'));

% Test 2: Surplus solar charges the battery
r2 = Smart_EMS(50, 150, 100);
assert(r2.solarToLoad == 100);
assert(r2.surplusSolar == 50);
assert(strcmp(r2.batteryAction, 'Charge'));

% Test 3: Low battery does not discharge
r3 = Smart_EMS(20, 0, 100);
assert(strcmp(r3.batteryAction, 'Idle'));

disp('All basic Smart EMS tests passed.');
