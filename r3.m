function R = r3(theta)
	% Returns Euler rotation-3 matrix given a rotation in radians.
	% R = r3(theta)
	R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
end