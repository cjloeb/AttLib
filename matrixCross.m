function M = matrixCross(v)
    % Returns a cross-product version of a column vector
    % M = matrixCross(v)
    M = [0 -v(3) v(2);
		   v(3) 0 -v(1);
		   -v(2) v(1) 0];
end