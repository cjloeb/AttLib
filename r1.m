function R = r1(theta)
	% Returns Euler rotation-1 matrix given a rotation in radians.
	% R = r1(theta)
	R = [1 0 0; 0 cos(theta) sin(theta); 0 -sin(theta) cos(theta)];
end