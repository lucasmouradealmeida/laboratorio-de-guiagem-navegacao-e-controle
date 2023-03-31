function [t1, t2, x1_1, x2_1, x1_2, x2_2, x3_2] = landing (h0, v0, mass, fuel, g, k, mu)

m = mass + fuel;

fun = @(x)otm(x, h0, v0, m, g, k, mu);
[sol] = fsolve(fun, [130 ; 200]);

t1 = sol(1);
t2 = sol(2);

x1_1 = @(t) -0.5 .* g .* t.^2 + v0 .* t + h0;
x2_1 = @(t) v0 - g .* t;
x3_2 = @(t) m - mu .* (t - t1);
x2_2 = @(t) x2_1(t1) - g .* (t - t1) - k .* log(1 - (mu / m) .* (t - t1));
x1_2 = @(t) x1_1(t1) + (k + x2_1(t1)) .* (t - t1) - 0.5 .* g .* (t - t1).^2 +...
    (m * k / mu) .* (1 - (mu / m) .* (t - t1)) .* log(1 - (mu / m) .* (t - t1));

end

function F = otm( x, h0, v0, m, g, k, mu )

F = [v0 - g * x(1) - g * (x(2) - x(1)) - k * log(1 - (mu / m) * (x(2) - x(1))) ; ...
     -0.5 * g * x(1)^2 + v0 * x(1) + h0 + (k + v0 - g * x(1)) * (x(2) - x(1)) ...
     - 0.5 * g * (x(2) - x(1))^2 + (m * k / mu) * (1 - (mu / m) * (x(2) - x(1))) ...
     * log(1 - (mu / m) * (x(2) - x(1)))];

end
