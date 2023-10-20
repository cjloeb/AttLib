function [phi, theta, psi] = DCMtoEA323(C)
	% Returns a 3-2-3 Euler angle sequence in radians given a DCM.
	% [phi, theta, psi] = DCMtoEA323(C)
	phi = atan2(C(3, 2), C(3, 1));
	theta = acos(C(3, 3));
	psi = atan2(C(2, 3), -C(1, 3));
end