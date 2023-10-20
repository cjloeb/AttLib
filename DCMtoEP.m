function ep = DCMtoEP(C)
	% Returns a quaternion given a DCM.
	% This function uses Sheppard's method, and it chooses a positive
	% epsilon_4 value only.
	% [ep] = DCMtoEP(C)
	% TODO: there is probably a better way to do this...
	e1 = sqrt(0.25 * (1 + 2*C(1, 1) - trace(C)));
	e2 = sqrt(0.25 * (1 + 2*C(2, 2) - trace(C)));
	e3 = sqrt(0.25 * (1 + 2*C(3, 3) - trace(C)));
	e4 = sqrt(0.25 * (1 + trace(C)));
	mode = max([e1 e2 e3 e4]);

	if mode == e1
		e2 = (C(1, 2) + C(2, 1)) / (4 * e1);
		e3 = (C(3, 1) + C(1, 3)) / (4 * e1);
		e4 = (C(2, 3) - C(3, 2)) / (4 * e1);
	elseif mode == e2
		e1 = (C(1, 2) + C(2, 1)) / (4 * e2);
		e3 = (C(2, 3) + C(3, 2)) / (4 * e2);
		e4 = (C(3, 1) - C(1, 3)) / (4 * e2);
	elseif mode == e3
		e2 = (C(2, 3) + C(3, 2)) / (4 * e3);
		e1 = (C(3, 1) + C(1, 3)) / (4 * e3);
		e4 = (C(3, 3) - C(3, 2)) / (4 * e3);
	elseif mode == e4
		e1 = (C(2, 3) - C(3, 2)) / (4 * e4);
		e2 = (C(3, 1) - C(1, 3)) / (4 * e4);
		e3 = (C(1, 2) - C(2, 1)) / (4 * e4);
	else
		error('DCMtoEP: Maximum magnitude is undefined. The quaternion returned is NOT correct.')
	end
	ep = sign(e4) .* [e1; e2; e3];
	ep = [ep; abs(e4)'];
end