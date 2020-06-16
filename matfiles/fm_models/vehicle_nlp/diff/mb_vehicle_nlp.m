function [ statesdot, outputs, j_statesdot, j_outputs ] = mb_vehicle_nlp( states, controls )
%mb_vehicle_nlp
% File automatically generated by FALCON.m

%=== Extract Data From Input ==============================================
t = states(1);
v = states(2);
psi_dot = states(3);
beta = states(4);
n = states(5);
xi = states(6);
objective = states(7);
delta = controls(1);
fB = controls(2);
zeta = controls(3);
phi = controls(4);
C = controls(5);

%=== Jacobians and Hessians ===============================================
j_t = zeros(1,12);
j_t(:,1) = eye(1);
j_v = zeros(1,12);
j_v(:,2) = eye(1);
j_psi_dot = zeros(1,12);
j_psi_dot(:,3) = eye(1);
j_beta = zeros(1,12);
j_beta(:,4) = eye(1);
j_n = zeros(1,12);
j_n(:,5) = eye(1);
j_xi = zeros(1,12);
j_xi(:,6) = eye(1);
j_objective = zeros(1,12);
j_objective(:,7) = eye(1);
j_delta = zeros(1,12);
j_delta(:,8) = eye(1);
j_fB = zeros(1,12);
j_fB(:,9) = eye(1);
j_zeta = zeros(1,12);
j_zeta(:,10) = eye(1);
j_phi = zeros(1,12);
j_phi(:,11) = eye(1);
j_C = zeros(1,12);
j_C(:,12) = eye(1);

% Combine Variables to states
states = [t; v; psi_dot; beta; n; xi; objective];
j_states = [j_t(1,:); j_v(1,:); j_psi_dot(1,:); j_beta(1,:); j_n(1,:); j_xi(1,:); j_objective(1,:)];

% Combine Variables to controls
controls = [delta; fB; zeta; phi; C];
j_controls = [j_delta(1,:); j_fB(1,:); j_zeta(1,:); j_phi(1,:); j_C(1,:)];

%=== Write Constants ======================================================

%=== Call tpc2db278e_9461_4022_bd68_94b600669896 ==========================
[v_dot, beta_dot, psi_dot_dot, n_wheel, M_wheel, T_M, j_v_dot, j_beta_dot, j_psi_dot_dot, j_n_wheel, j_M_wheel, j_T_M] = tpc2db278e_9461_4022_bd68_94b600669896(v, beta, psi_dot, delta, fB, zeta, phi);

% Hessian Jacobian for tpc2db278e_9461_4022_bd68_94b600669896
tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896 = [j_v; j_beta; j_psi_dot; j_delta; j_fB; j_zeta; j_phi];

% Calculation of Jacobian with respect to function global input for tpc2db278e_9461_4022_bd68_94b600669896
j_v_dot = j_v_dot * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;
j_beta_dot = j_beta_dot * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;
j_psi_dot_dot = j_psi_dot_dot * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;
j_n_wheel = j_n_wheel * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;
j_M_wheel = j_M_wheel * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;
j_T_M = j_T_M * tmp_j_input_tpc2db278e_9461_4022_bd68_94b600669896;

%=== Call tpc5c59c9c_faa3_4db8_910e_3caccb09abd0 ==========================
[s_dot, n_dot, xi_dot, j_s_dot, j_n_dot, j_xi_dot] = tpc5c59c9c_faa3_4db8_910e_3caccb09abd0(psi_dot, v, beta, n, xi, C);

% Hessian Jacobian for tpc5c59c9c_faa3_4db8_910e_3caccb09abd0
tmp_j_input_tpc5c59c9c_faa3_4db8_910e_3caccb09abd0 = [j_psi_dot; j_v; j_beta; j_n; j_xi; j_C];

% Calculation of Jacobian with respect to function global input for tpc5c59c9c_faa3_4db8_910e_3caccb09abd0
j_s_dot = j_s_dot * tmp_j_input_tpc5c59c9c_faa3_4db8_910e_3caccb09abd0;
j_n_dot = j_n_dot * tmp_j_input_tpc5c59c9c_faa3_4db8_910e_3caccb09abd0;
j_xi_dot = j_xi_dot * tmp_j_input_tpc5c59c9c_faa3_4db8_910e_3caccb09abd0;

%=== Call tp59c10185_e21b_4bbc_8d36_f4df91987fc9 ==========================
[objective_dot, j_objective_dot] = tp59c10185_e21b_4bbc_8d36_f4df91987fc9(delta, fB, phi, zeta);

% Hessian Jacobian for tp59c10185_e21b_4bbc_8d36_f4df91987fc9
tmp_j_input_tp59c10185_e21b_4bbc_8d36_f4df91987fc9 = [j_delta; j_fB; j_phi; j_zeta];

% Calculation of Jacobian with respect to function global input for tp59c10185_e21b_4bbc_8d36_f4df91987fc9
j_objective_dot = j_objective_dot * tmp_j_input_tp59c10185_e21b_4bbc_8d36_f4df91987fc9;

%=== Call tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed ==========================
[t_dot_s, v_dot_s, psi_dot_dot_s, beta_dot_s, n_dot_s, xi_dot_s, objective_dot_s, j_t_dot_s, j_v_dot_s, j_psi_dot_dot_s, j_beta_dot_s, j_n_dot_s, j_xi_dot_s, j_objective_dot_s] = tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed(v_dot, psi_dot_dot, beta_dot, n_dot, xi_dot, s_dot, objective_dot);

% Hessian Jacobian for tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed
tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed = [j_v_dot; j_psi_dot_dot; j_beta_dot; j_n_dot; j_xi_dot; j_s_dot; j_objective_dot];

% Calculation of Jacobian with respect to function global input for tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed
j_t_dot_s = j_t_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_v_dot_s = j_v_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_psi_dot_dot_s = j_psi_dot_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_beta_dot_s = j_beta_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_n_dot_s = j_n_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_xi_dot_s = j_xi_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;
j_objective_dot_s = j_objective_dot_s * tmp_j_input_tp0f466f37_8fd8_4d3b_9b59_6b6a054367ed;

% Combine Variables to statesdot
statesdot = [t_dot_s; v_dot_s; psi_dot_dot_s; beta_dot_s; n_dot_s; xi_dot_s; objective_dot_s];
j_statesdot = [j_t_dot_s(1,:); j_v_dot_s(1,:); j_psi_dot_dot_s(1,:); j_beta_dot_s(1,:); j_n_dot_s(1,:); j_xi_dot_s(1,:); j_objective_dot_s(1,:)];

% Combine Variables to outputs
outputs = [n_wheel; M_wheel; T_M];
j_outputs = [j_n_wheel(1,:); j_M_wheel(1,:); j_T_M(1,:)];

end
