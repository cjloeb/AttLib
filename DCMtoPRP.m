function [theta, lambda] = DCMtoPRP(C)
	% Returns a PRP representation given a DCM.
	% Theta is wrapped to Pi.
	% [theta, lambda] = DCMtoPRP(C)
	theta = wrapToPi(acos(0.5 * (C(1, 1) + C(2, 2) + C(3, 3) - 1)));
	l1 = C(2, 3) - C(3, 2);
	l2 = C(3, 1) - C(1, 3);
	l3 = C(1, 2) - C(2, 1);
	lambda = [l1 l2 l3]' ./ (2 * sin(theta));
end