function k = lqrtest(states, v, psi_dot, beta, delta, Fb, zeta, phi, C, vTarget, psi_dotTarget, betaTarget, nTarget, xiTarget, deltaFF)
%     state = [0; v; psi_dot; beta; states(2); states(3); 0; delta];
    
    linearization_state = [0; vTarget; psi_dotTarget; betaTarget; nTarget; xiTarget; 0; deltaFF];
    linearization_control = [0; Fb; zeta; phi; C];
    
    [state_dot_s, ~, track_state_jac, ~] = mb_vehicle_nlp(linearization_state, linearization_control);
%     state_dot_s = state_dot_s(1:7);                         % Get rid of delta as a state
    track_state_jac = track_state_jac(1:7, [1:8, 10:end]);  % Get rid of delta as a state and replace delta_dot with delta as a control
%     s_dot = v * cos(-beta + states(3)) / (1 - states(2) * C);
    
%     state_dot = state_dot_s * s_dot;
    
    controlSelector = 1;    % Give the LQR only delta to play with
    stateSelector = 2:6;    % Only v, psi_dot, beta, n, xi are usefull states
    
    A = track_state_jac(stateSelector, stateSelector);
    B = track_state_jac(stateSelector, 7 + controlSelector);
    
    Q = 1e-1*diag([0, 1, 1, 1, 1]);  % Don't care about v, since we can't really change anything about it with delta
    R = diag([1]);
    
    k = lqr(A, B, Q, R);
    
%     delta = linearization_control(controlSelector) - K * (state(stateSelector) - linearization_state(stateSelector));
end