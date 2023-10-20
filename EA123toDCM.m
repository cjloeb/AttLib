function C = EA123toDCM(phi, theta, psi)
	% Returns a DCM given a 1-2-3 Euler angle sequence in radians.
	% C = EA123toDCM(phi, theta, psi)
	C = AttLib.r3(psi) * AttLib.r2(theta) * AttLib.r1(phi);
end