function C = EPtoDCM(ep)
	% Returns a DCM given a quaternion.
	% C = EPtoDCM(ep)
	e1 = ep(1);
	e2 = ep(2);
	e3 = ep(3);
	e4 = ep(4);

	C1 = [1 - 2*e2^2 - 2*e3^2, 2*(e1*e2 + e3*e4), 2*(e1*e3 - e2*e4)];
	C2 = [2*(e1*e2 - e3*e4), 1 - 2*e1^2 - 2*e3^2, 2*(e2*e3 + e1*e4)];
	C3 = [2*(e1*e3 + e2*e4), 2*(e2*e3 - e1*e4), 1 - 2*e1^2 - 2*e2^2];
	C = [C1; C2; C3];
end