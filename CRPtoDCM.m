function C = CRPtoDCM(crp)
	% Returns a DCM given a CRP representation.
	% C = CRPtoDCM(crp)
	p1 = crp(1);
	p2 = crp(2);
	p3 = crp(3);

	C1 = [1 + p1^2 - p2^2 - p3^2, 2*(p1*p2 + p3), 2*(p1*p3 - p2)];
	C2 = [2*(p1*p2 - p3), 1 - p1^2 + p2^2 - p3^2, 2*(p2*p3 + p1)];
	C3 = [2*(p1*p3 + p2), 2*(p2*p3 - p1), 1 - p1^2 - p2^2 + p3^2];
	C = [C1; C2; C3] ./ (1 + dot(crp, crp)); 
end