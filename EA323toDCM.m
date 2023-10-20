function C = EA323toDCM(phi, theta, psi)
	% Returns a DCM given a 3-2-3 Euler angle sequence in radians.
	% C = EA323toDCM(phi, theta, psi)
	C = AttLib.r3(psi) * AttLib.r2(theta) * AttLib.r3(phi);
end