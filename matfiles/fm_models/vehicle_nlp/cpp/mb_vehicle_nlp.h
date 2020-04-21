/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mb_vehicle_nlp.h
 *
 * Code generation for function 'mb_vehicle_nlp'
 *
 */

#ifndef MB_VEHICLE_NLP_H
#define MB_VEHICLE_NLP_H

/* Include files */
#include <cstddef>
#include <cstdlib>
#include "rtwtypes.h"
#include "mb_vehicle_nlp_types.h"

/* Function Declarations */
extern void mb_vehicle_nlp(const double states[6], const double controls[5],
  double statesdot[6], double j_statesdot[66]);
extern void mb_vehicle_nlp_initialize();
extern void mb_vehicle_nlp_terminate();

#endif

/* End of code generation (mb_vehicle_nlp.h) */
