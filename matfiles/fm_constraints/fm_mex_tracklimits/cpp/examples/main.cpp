/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.cpp
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include files */
#include "main.h"
#include "mb_fm_mex_tracklimits.h"

/* Function Declarations */
static void argInit_4x1_real_T(double result[4]);
static void argInit_7x1_real_T(double result[7]);
static void argInit_8x1_real_T(double result[8]);
static double argInit_real_T();
static void main_mb_fm_mex_tracklimits();

/* Function Definitions */
static void argInit_4x1_real_T(double result[4])
{
  double result_tmp_tmp;

  /* Loop over the array to initialize each element. */
  /* Set the value of the array element.
     Change this value to the value that the application requires. */
  result_tmp_tmp = argInit_real_T();
  result[0] = result_tmp_tmp;

  /* Set the value of the array element.
     Change this value to the value that the application requires. */
  result[1] = result_tmp_tmp;

  /* Set the value of the array element.
     Change this value to the value that the application requires. */
  result[2] = result_tmp_tmp;

  /* Set the value of the array element.
     Change this value to the value that the application requires. */
  result[3] = argInit_real_T();
}

static void argInit_7x1_real_T(double result[7])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 7; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static void argInit_8x1_real_T(double result[8])
{
  int idx0;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 8; idx0++) {
    /* Set the value of the array element.
       Change this value to the value that the application requires. */
    result[idx0] = argInit_real_T();
  }
}

static double argInit_real_T()
{
  return 0.0;
}

static void main_mb_fm_mex_tracklimits()
{
  double dv[4];
  double dv1[8];
  double dv2[7];
  double constraintvalue;
  double j_constraintvalue[19];

  /* Initialize function 'mb_fm_mex_tracklimits' input arguments. */
  /* Initialize function input argument 'outputs'. */
  /* Initialize function input argument 'states'. */
  /* Initialize function input argument 'controls'. */
  /* Call the entry-point 'mb_fm_mex_tracklimits'. */
  argInit_4x1_real_T(dv);
  argInit_8x1_real_T(dv1);
  argInit_7x1_real_T(dv2);
  mb_fm_mex_tracklimits(dv, dv1, dv2, &constraintvalue, j_constraintvalue);
}

int main(int, const char * const [])
{
  /* The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_mb_fm_mex_tracklimits();

  /* Terminate the application.
     You do not need to do this more than one time. */
  mb_fm_mex_tracklimits_terminate();
  return 0;
}

/* End of code generation (main.cpp) */
