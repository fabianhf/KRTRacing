/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_mb_vehicle_nlp_api.h
 *
 * Code generation for function '_coder_mb_vehicle_nlp_api'
 *
 */

#ifndef _CODER_MB_VEHICLE_NLP_API_H
#define _CODER_MB_VEHICLE_NLP_API_H

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
extern void mb_vehicle_nlp(real_T states[6], real_T controls[5], real_T
  statesdot[6], real_T j_statesdot[66]);
extern void mb_vehicle_nlp_api(const mxArray * const prhs[2], int32_T nlhs,
  const mxArray *plhs[2]);
extern void mb_vehicle_nlp_atexit(void);
extern void mb_vehicle_nlp_initialize(void);
extern void mb_vehicle_nlp_terminate(void);
extern void mb_vehicle_nlp_xil_shutdown(void);
extern void mb_vehicle_nlp_xil_terminate(void);

#endif

/* End of code generation (_coder_mb_vehicle_nlp_api.h) */
