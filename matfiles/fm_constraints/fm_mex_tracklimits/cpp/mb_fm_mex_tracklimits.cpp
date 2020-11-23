/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mb_fm_mex_tracklimits.cpp
 *
 * Code generation for function 'mb_fm_mex_tracklimits'
 *
 */

/* Include files */
#include "mb_fm_mex_tracklimits.h"

/* Function Definitions */
void mb_fm_mex_tracklimits(const double [4], const double states[8], const
  double controls[7], double *constraintvalue, double j_constraintvalue[19])
{
  int i;
  signed char j_n_wheel[19];
  signed char j_M_wheel[19];
  signed char j_a_r[19];
  signed char j_a_f[19];
  signed char j_t[19];
  signed char j_v[19];
  signed char j_psi_dot[19];
  signed char j_beta[19];
  signed char j_n[19];
  signed char j_xi[19];
  signed char j_objective[19];
  signed char j_delta[19];
  signed char j_delta_dot[19];
  signed char j_fB[19];
  signed char j_zeta[19];
  signed char j_phi[19];
  signed char j_C[19];
  signed char j_nCurbLeft[19];
  signed char j_nCurbRight[19];
  signed char b_j_n_wheel[361];
  double d;
  int i1;
  static const signed char j_constraintvaluetmp[19] = { 0, 0, 0, 0, 0, 0, 0, 0,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1 };

  /* mb_fm_mex_tracklimits */
  /*  File automatically generated by FALCON.m */
  /* === Extract Data From Input ============================================== */
  /* === Jacobians and Hessians =============================================== */
  for (i = 0; i < 19; i++) {
    j_n_wheel[i] = 0;
    j_M_wheel[i] = 0;
    j_a_r[i] = 0;
    j_a_f[i] = 0;
    j_t[i] = 0;
    j_v[i] = 0;
    j_psi_dot[i] = 0;
    j_beta[i] = 0;
    j_n[i] = 0;
    j_xi[i] = 0;
    j_objective[i] = 0;
    j_delta[i] = 0;
    j_delta_dot[i] = 0;
    j_fB[i] = 0;
    j_zeta[i] = 0;
    j_phi[i] = 0;
    j_C[i] = 0;
    j_nCurbLeft[i] = 0;
    j_nCurbRight[i] = 0;
  }

  j_n_wheel[0] = 1;
  j_M_wheel[1] = 1;
  j_a_r[2] = 1;
  j_a_f[3] = 1;
  j_t[4] = 1;
  j_v[5] = 1;
  j_psi_dot[6] = 1;
  j_beta[7] = 1;
  j_n[8] = 1;
  j_xi[9] = 1;
  j_objective[10] = 1;
  j_delta[11] = 1;
  j_delta_dot[12] = 1;
  j_fB[13] = 1;
  j_zeta[14] = 1;
  j_phi[15] = 1;
  j_C[16] = 1;
  j_nCurbLeft[17] = 1;
  j_nCurbRight[18] = 1;

  /*  Combine Variables to outputs */
  /*  Combine Variables to states */
  /*  Combine Variables to controls */
  /* === Write Constants ====================================================== */
  /* === Call tpae0fcf33_9608_4636_96c4_6aa4549f9ab7 ========================== */
  /* TPAE0FCF33_9608_4636_96C4_6AA4549F9AB7 */
  /*     [OUT1,OUT2,OUT3] = TPAE0FCF33_9608_4636_96C4_6AA4549F9AB7(IN1,IN2,IN3) */
  /*     This function was generated by the Symbolic Math Toolbox version 8.4. */
  /*     20-Jun-2020 13:12:30 */
  *constraintvalue = (states[4] + controls[5]) - controls[6];

  /*  Hessian Jacobian for tpae0fcf33_9608_4636_96c4_6aa4549f9ab7 */
  /*  Calculation of Jacobian with respect to function global input for tpae0fcf33_9608_4636_96c4_6aa4549f9ab7 */
  for (i = 0; i < 19; i++) {
    b_j_n_wheel[19 * i] = j_n_wheel[i];
    b_j_n_wheel[19 * i + 1] = j_M_wheel[i];
    b_j_n_wheel[19 * i + 2] = j_a_r[i];
    b_j_n_wheel[19 * i + 3] = j_a_f[i];
    b_j_n_wheel[19 * i + 4] = j_t[i];
    b_j_n_wheel[19 * i + 5] = j_v[i];
    b_j_n_wheel[19 * i + 6] = j_psi_dot[i];
    b_j_n_wheel[19 * i + 7] = j_beta[i];
    b_j_n_wheel[19 * i + 8] = j_n[i];
    b_j_n_wheel[19 * i + 9] = j_xi[i];
    b_j_n_wheel[19 * i + 10] = j_objective[i];
    b_j_n_wheel[19 * i + 11] = j_delta[i];
    b_j_n_wheel[19 * i + 12] = j_delta_dot[i];
    b_j_n_wheel[19 * i + 13] = j_fB[i];
    b_j_n_wheel[19 * i + 14] = j_zeta[i];
    b_j_n_wheel[19 * i + 15] = j_phi[i];
    b_j_n_wheel[19 * i + 16] = j_C[i];
    b_j_n_wheel[19 * i + 17] = j_nCurbLeft[i];
    b_j_n_wheel[19 * i + 18] = j_nCurbRight[i];
    d = 0.0;
    for (i1 = 0; i1 < 19; i1++) {
      d += static_cast<double>(j_constraintvaluetmp[i1] * b_j_n_wheel[i1 + 19 *
        i]);
    }

    j_constraintvalue[i] = d;
  }

  /*  Combine Variables to constraintvalue */
}

void mb_fm_mex_tracklimits_initialize()
{
}

void mb_fm_mex_tracklimits_terminate()
{
  /* (no terminate code required) */
}

/* End of code generation (mb_fm_mex_tracklimits.cpp) */