/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_mb_fm_mex_tracklimits_api.h
 *
 * Code generation for function '_coder_mb_fm_mex_tracklimits_api'
 *
 */

#ifndef _CODER_MB_FM_MEX_TRACKLIMITS_API_H
#define _CODER_MB_FM_MEX_TRACKLIMITS_API_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void mb_fm_mex_tracklimits(real_T outputs[4], real_T states[8], real_T
  controls[7], real_T *constraintvalue, real_T j_constraintvalue[19]);
extern void mb_fm_mex_tracklimits_api(const mxArray * const prhs[3], int32_T
  nlhs, const mxArray *plhs[2]);
extern void mb_fm_mex_tracklimits_atexit(void);
extern void mb_fm_mex_tracklimits_initialize(void);
extern void mb_fm_mex_tracklimits_terminate(void);
extern void mb_fm_mex_tracklimits_xil_shutdown(void);
extern void mb_fm_mex_tracklimits_xil_terminate(void);

#endif

/* End of code generation (_coder_mb_fm_mex_tracklimits_api.h) */
