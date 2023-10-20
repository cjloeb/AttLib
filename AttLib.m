classdef AttLib
    % Attitude function library for AAE 440

    methods (Static)
        function R = r1(theta)
            % Returns Euler rotation-1 matrix given a rotation in radians.
            % R = r1(theta)
            R = [1 0 0; 0 cos(theta) sin(theta); 0 -sin(theta) cos(theta)];
        end

        function R = r2(theta)
            % Returns Euler rotation-2 matrix given a rotation in radians.
            % R = r2(theta)
            R = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
        end

        function R = r3(theta)
            % Returns Euler rotation-3 matrix given a rotation in radians.
            % R = r3(theta)
            R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
        end

        function C = EA123toDCM(phi, theta, psi)
            % Returns a DCM given a 1-2-3 Euler angle sequence in radians.
            % C = EA123toDCM(phi, theta, psi)
            C = AttLib.r3(psi) * AttLib.r2(theta) * AttLib.r1(phi);
        end

        function [phi, theta, psi] = DCMtoEA323(C)
            % Returns a 3-2-3 Euler angle sequence in radians given a DCM.
            % [phi, theta, psi] = DCMtoEA323(C)
            phi = atan2(C(3, 2), C(3, 1));
            theta = acos(C(3, 3));
            psi = atan2(C(2, 3), -C(1, 3));
        end

        function C = EA323toDCM(phi, theta, psi)
            % Returns a DCM given a 3-2-3 Euler angle sequence in radians.
            % C = EA323toDCM(phi, theta, psi)
            C = AttLib.r3(psi) * AttLib.r2(theta) * AttLib.r3(phi);
        end

        function [theta, lambda] = DCMtoPRP(C)
            % Returns a PRP representation given a DCM.
            % Theta is wrapped to Pi.
            % [theta, lambda] = DCMtoPRP(C)
            theta = wrapToPi(acos(0.5 * (C(1, 1) + C(2, 2) + C(3, 3) - 1)));
            l1 = C(2, 3) - C(3, 2);
            l2 = C(3, 1) - C(1, 3);
            l3 = C(1, 2) - C(2, 1);
            lambda = [l1 l2 l3]' ./ (2 * sin(theta));
        end

        function ep = DCMtoEP(C)
            % Returns a quaternion given a DCM.
            % This function uses Sheppard's method, and it chooses a positive
            % epsilon_4 value only.
            % [ep] = DCMtoEP(C)
            % TODO: there is probably a better way to do this...
            e1 = sqrt(0.25 * (1 + 2*C(1, 1) - trace(C)));
            e2 = sqrt(0.25 * (1 + 2*C(2, 2) - trace(C)));
            e3 = sqrt(0.25 * (1 + 2*C(3, 3) - trace(C)));
            e4 = sqrt(0.25 * (1 + trace(C)));
            mode = max([e1 e2 e3 e4]);
        
            if mode == e1
                e2 = (C(1, 2) + C(2, 1)) / (4 * e1);
                e3 = (C(3, 1) + C(1, 3)) / (4 * e1);
                e4 = (C(2, 3) - C(3, 2)) / (4 * e1);
            elseif mode == e2
                e1 = (C(1, 2) + C(2, 1)) / (4 * e2);
                e3 = (C(2, 3) + C(3, 2)) / (4 * e2);
                e4 = (C(3, 1) - C(1, 3)) / (4 * e2);
            elseif mode == e3
                e2 = (C(2, 3) + C(3, 2)) / (4 * e3);
                e1 = (C(3, 1) + C(1, 3)) / (4 * e3);
                e4 = (C(3, 3) - C(3, 2)) / (4 * e3);
            elseif mode == e4
                e1 = (C(2, 3) - C(3, 2)) / (4 * e4);
                e2 = (C(3, 1) - C(1, 3)) / (4 * e4);
                e3 = (C(1, 2) - C(2, 1)) / (4 * e4);
            else
                error('DCMtoEP: Maximum magnitude is undefined. The quaternion returned is NOT correct.')
            end
            ep = sign(e4) .* [e1; e2; e3];
            ep = [ep; abs(e4)'];
        end
        
        function ep = DCMtoEP_standard(C)
            % Returns a quaternion given a DCM.
            % This function is not numerically stable, and it should not be
            % used in most cases.
            % ep = DCMtoEP_standard(C)
            e4 = 0.5 * sqrt(1 + C(1, 1) + C(2, 2) + C(3, 3));
            e1 = (C(2, 3) - C(3, 2)) / (4*e4);
            e2 = (C(3, 1) - C(1, 3)) / (4*e4);
            e3 = (C(1, 2) - C(2, 1)) / (4*e4);
            ep = [e1 e2 e3 e4]';
        end

        function crp = DCMtoCRP(C)
            % Returns a CRP representation given a DCM.
            % [crp] = DCMtoCRP(C)
            p1 = C(2, 3) - C(3, 2);
            p2 = C(3, 1) - C(1, 3);
            p3 = C(1, 2) - C(2, 1);
            crp = [p1 p2 p3]' ./ (1 + C(1, 1) + C(2, 2) + C(3, 3));
        end

        function mrp = DCMtoMRP(C)
            % Returns a MRP representation given a DCM.
            % mrp = DCMtoMRP(C)
            d = sqrt(1 + C(1, 1) + C(2, 2) + C(3, 3));
            p1 = C(2, 3) - C(3, 2);
            p2 = C(3, 1) - C(1, 3);
            p3 = C(1, 2) - C(2, 1);
            mrp = [p1 p2 p3]' ./ (d * (d + 2));
        end

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

        function C = MRPtoDCM(mrp)
            % Returns a DCM given an MRP representation.
            % C = MRPtoDCM(mrp)
            scp = [0 -mrp(3) mrp(2);
                   mrp(3) 0 -mrp(1);
                   -mrp(2) mrp(1) 0];
            ss = dot(mrp, mrp);
            C = eye(3) + ((8*scp*scp - 4*(1 - ss)*scp) / ((1 + ss)^2));
        end
    end
end