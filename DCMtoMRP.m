function mrp = DCMtoMRP(C)
	% Returns a MRP representation given a DCM.
	% mrp = DCMtoMRP(C)
	d = sqrt(1 + C(1, 1) + C(2, 2) + C(3, 3));
	p1 = C(2, 3) - C(3, 2);
	p2 = C(3, 1) - C(1, 3);
	p3 = C(1, 2) - C(2, 1);
	mrp = [p1 p2 p3]' ./ (d * (d + 2));
end