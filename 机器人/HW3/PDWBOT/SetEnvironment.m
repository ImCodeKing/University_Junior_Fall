function Robot = SetEnvironment(Robot, Slope, Gravity)
%Set the slope and gravity of the Simulation.
%
%See also: Step.m, Walk.m.

Robot.gamma = Slope;    % Slope of ground (radians)
Robot.g = Gravity;      % mm/sec^2


       