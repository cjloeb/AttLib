function C = MRPtoDCM(mrp)
	% Returns a DCM given an MRP representation.
	% C = MRPtoDCM(mrp)
	scp = [0 -mrp(3) mrp(2);
		   mrp(3) 0 -mrp(1);
		   -mrp(2) mrp(1) 0];
	ss = dot(mrp, mrp);
	C = eye(3) + ((8*scp*scp - 4*(1 - ss)*scp) / ((1 + ss)^2));
end