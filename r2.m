function R = r2(theta)
	% Returns Euler rotation-2 matrix given a rotation in radians.
	% R = r2(theta)
	R = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
end