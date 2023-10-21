function symPrint(eq, label)
    % Prints an equation (or other symbolic expression)
    % symPrint(eq, label)
    sympref('MatrixWithSquareBrackets', 'default'); % for display
    digits(4) % for rounding
    fprintf(label + " = ");
    disp(sym(vpa(eq)));
end