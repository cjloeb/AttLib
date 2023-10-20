function C = PRPtoDCM(theta, lambda)
	% Returns a DCM given a PRP representation.
	% C = PRPtoDCM(theta, lambda)
	l1 = lambda(1);
	l2 = lambda(2);
	l3 = lambda(3);
	c = cos(theta);
	s = sin(theta);

	C1 = [(1-c)*l1^2 + c, (1-c)*l1*l2 + l3*s, (1-c)*l1*l3 - l2*s];
	C2 = [(1-c)*l2*l1 - l3*s, (1-c)*l2^2 + c, (1-c)*l2*l3 + l1*s];
	C3 = [(1-c)*l3*l1 + l2*s, (1-c)*l3*l2 - l1*s, (1-c)*l3^2 + c];
	C = [C1; C2; C3];
end