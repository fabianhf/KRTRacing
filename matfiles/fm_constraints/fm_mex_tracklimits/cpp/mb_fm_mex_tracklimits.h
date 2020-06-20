/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mb_fm_mex_tracklimits.h
 *
 * Code generation for function 'mb_fm_mex_tracklimits'
 *
 */

#ifndef MB_FM_MEX_TRACKLIMITS_H
#define MB_FM_MEX_TRACKLIMITS_H

/* Include files */
#include <cstddef>
#include <cstdlib>
#include "rtwtypes.h"
#include "mb_fm_mex_tracklimits_types.h"

/* Function Declarations */
extern void mb_fm_mex_tracklimits(const double outputs[4], const double states[8],
  const double controls[7], double *constraintvalue, double j_constraintvalue[19]);
extern void mb_fm_mex_tracklimits_initialize();
extern void mb_fm_mex_tracklimits_terminate();

#endif

/* End of code generation (mb_fm_mex_tracklimits.h) */
