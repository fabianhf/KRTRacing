
t = 1;
X_1 = rand(1, 10);
X_1(9) = X_1(6); % phi_dot = omega
X_2 = rand(1, 10);
X_2(9) = X_2(6); % phi_dot = omega
sel_states = [3, 4, 9];
vectorVersion = singletrackVectorValues([X_1(sel_states); X_2(sel_states)], [controller(X_1); controller(X_2)]);
scalarVersion = transpose([singletrack(t, X_1), singletrack(t, X_2)]);

difference = scalarVersion(:, sel_states) - vectorVersion;

if any(difference, 'all')
    error('Test failed!')
end