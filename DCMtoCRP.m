function crp = DCMtoCRP(C)
	% Returns a CRP representation given a DCM.
	% [crp] = DCMtoCRP(C)
	p1 = C(2, 3) - C(3, 2);
	p2 = C(3, 1) - C(1, 3);
	p3 = C(1, 2) - C(2, 1);
	crp = [p1 p2 p3]' ./ (1 + C(1, 1) + C(2, 2) + C(3, 3));
end