/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_mb_vehicle_nlp_mex.c
 *
 * Code generation for function '_coder_mb_vehicle_nlp_mex'
 *
 */

/* Include files */
#include "_coder_mb_vehicle_nlp_mex.h"
#include "_coder_mb_vehicle_nlp_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void mb_vehicle_nlp_mexFunction(int32_T nlhs, mxArray *plhs
  [4], int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */
void mb_vehicle_nlp_mexFunction(int32_T nlhs, mxArray *plhs[4], int32_T nrhs,
  const mxArray *prhs[2])
{
  const mxArray *outputs[4];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        14, "mb_vehicle_nlp");
  }

  if (nlhs > 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 14,
                        "mb_vehicle_nlp");
  }

  /* Call the function. */
  mb_vehicle_nlp_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(mb_vehicle_nlp_atexit);

  /* Module initialization. */
  mb_vehicle_nlp_initialize();

  /* Dispatch the entry-point. */
  mb_vehicle_nlp_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  mb_vehicle_nlp_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_mb_vehicle_nlp_mex.c) */
