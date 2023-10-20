function ep = DCMtoEP_standard(C)
	% Returns a quaternion given a DCM.
	% This function is not numerically stable, and it should not be
	% used in most cases.
	% ep = DCMtoEP_standard(C)
	e4 = 0.5 * sqrt(1 + C(1, 1) + C(2, 2) + C(3, 3));
	e1 = (C(2, 3) - C(3, 2)) / (4*e4);
	e2 = (C(3, 1) - C(1, 3)) / (4*e4);
	e3 = (C(1, 2) - C(2, 1)) / (4*e4);
	ep = [e1 e2 e3 e4]';
end