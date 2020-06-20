// Call Function generated automatically on 20-Jun-2020 13:12:33
// Created on fabianhf
#include "mex.h"
#include "math.h"
#include "mb_fm_mex_tracklimits.h"

// Constants - Input Dimensions
#define DIM_M_OUTPUTS 4
#define DIM_M_STATES 8
#define DIM_M_CONTROLS 7

// Constants - Number of Independent Variables (non discrete control case)
#define N_IDP 19

// Constants - Output Sizes
#define NUM_OUT_CONSTRAINTVALUE 1

// Function Header
void mexFunction( int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[] ) {
	
	// Define Inputs
	double *outputs;
	double *states;
	double *controls;
	
	// Declare number of time steps
	int nEval;
	
	// Declare Outputs
	double *constraintvalue, *j_constraintvalue;
	mwSize j_dim_constraintvalue[3];
	
	// Write Call Information
	if (nrhs == 0 && nlhs == 0) {
		// System Information
		mexPrintf("<strong>System Information</strong>\n");
		mexPrintf("Mex file created by Derivative Model Builder\n");
		mexPrintf("- Date:                20-Jun-2020 13:12:33\n");
		mexPrintf("- Computer:            fabianhf\n");
		mexPrintf("- MATLAB-Version:      9.7.0.1319299 (R2019b) Update 5\n");
		mexPrintf("- Hessian-Calculation: false\n");
		mexPrintf("\n");
		
		// Input Information
		mexPrintf("<strong>Input Information</strong>\n");
		mexPrintf("<strong>Name</strong>     <strong>Size</strong>  <strong>Derivative</strong> <strong>MultipleTimeEval</strong> <strong>VariableSize</strong>\n");
		mexPrintf("outputs  [4 1]       true             true        false\n");
		mexPrintf("| n_wheel\n");
		mexPrintf("| M_wheel\n");
		mexPrintf("| a_r\n");
		mexPrintf("| a_f\n");
		mexPrintf("\n");
		mexPrintf("states   [8 1]       true             true        false\n");
		mexPrintf("| t\n");
		mexPrintf("| v\n");
		mexPrintf("| psi_dot\n");
		mexPrintf("| beta\n");
		mexPrintf("| n\n");
		mexPrintf("| xi\n");
		mexPrintf("| objective\n");
		mexPrintf("| delta\n");
		mexPrintf("\n");
		mexPrintf("controls [7 1]       true             true        false\n");
		mexPrintf("| delta_dot\n");
		mexPrintf("| fB\n");
		mexPrintf("| zeta\n");
		mexPrintf("| phi\n");
		mexPrintf("| C\n");
		mexPrintf("| nCurbLeft\n");
		mexPrintf("| nCurbRight\n");
		mexPrintf("\n");
		mexPrintf("\n");
		
		// Output Information
		mexPrintf("<strong>Output Information</strong>\n");
		mexPrintf("<strong>Name</strong>            <strong>Size</strong> \n");
		mexPrintf("constraintvalue [1 1]\n");
		
		return;
	}
	else if (nrhs == 0 && nlhs == 1) {
		const char *names[] = {"input", "output", "info", "name", "type"};
		const char *i_names[] = {"m", "n","name","argnames","type", "groupindex"};
		const char *o_names[] = {"m", "n","name","argnames","type","jac_sparsity","hess_sparsity"};
		mxArray *struct_inputs;
		mxArray *struct_outputs;
		const char *info_names[] = {"Date", "Computer","MATLAB","Hessian"};
		mxArray *struct_info;
		mxArray *mx;
		double* jac_hess;
		plhs[0] = mxCreateStructMatrix(1,1,5,names);
		mxSetField(plhs[0], 0, names[3], mxCreateString("fm_mex_tracklimits"));
		mxSetField(plhs[0], 0, names[4], mxCreateString("PATH_FUNCTION"));
		struct_inputs = mxCreateStructMatrix(3,1,6,i_names);
		mxSetField(struct_inputs, 0, i_names[0], mxCreateDoubleScalar(4));
		mxSetField(struct_inputs, 0, i_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_inputs, 0, i_names[2], mxCreateString("outputs"));
		mxSetField(struct_inputs, 0, i_names[4], mxCreateString("OUTPUT"));
		mxSetField(struct_inputs, 0, i_names[5], mxCreateDoubleScalar(0));
		mx = mxCreateCellMatrix(4, 1);
		mxSetCell(mx, 0,  mxCreateString("n_wheel"));
		mxSetCell(mx, 1,  mxCreateString("M_wheel"));
		mxSetCell(mx, 2,  mxCreateString("a_r"));
		mxSetCell(mx, 3,  mxCreateString("a_f"));
		mxSetField(struct_inputs, 0, i_names[3], mx);
		mxSetField(struct_inputs, 1, i_names[0], mxCreateDoubleScalar(8));
		mxSetField(struct_inputs, 1, i_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_inputs, 1, i_names[2], mxCreateString("states"));
		mxSetField(struct_inputs, 1, i_names[4], mxCreateString("STATE"));
		mxSetField(struct_inputs, 1, i_names[5], mxCreateDoubleScalar(0));
		mx = mxCreateCellMatrix(8, 1);
		mxSetCell(mx, 0,  mxCreateString("t"));
		mxSetCell(mx, 1,  mxCreateString("v"));
		mxSetCell(mx, 2,  mxCreateString("psi_dot"));
		mxSetCell(mx, 3,  mxCreateString("beta"));
		mxSetCell(mx, 4,  mxCreateString("n"));
		mxSetCell(mx, 5,  mxCreateString("xi"));
		mxSetCell(mx, 6,  mxCreateString("objective"));
		mxSetCell(mx, 7,  mxCreateString("delta"));
		mxSetField(struct_inputs, 1, i_names[3], mx);
		mxSetField(struct_inputs, 2, i_names[0], mxCreateDoubleScalar(7));
		mxSetField(struct_inputs, 2, i_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_inputs, 2, i_names[2], mxCreateString("controls"));
		mxSetField(struct_inputs, 2, i_names[4], mxCreateString("CONTROL"));
		mxSetField(struct_inputs, 2, i_names[5], mxCreateDoubleScalar(0));
		mx = mxCreateCellMatrix(7, 1);
		mxSetCell(mx, 0,  mxCreateString("delta_dot"));
		mxSetCell(mx, 1,  mxCreateString("fB"));
		mxSetCell(mx, 2,  mxCreateString("zeta"));
		mxSetCell(mx, 3,  mxCreateString("phi"));
		mxSetCell(mx, 4,  mxCreateString("C"));
		mxSetCell(mx, 5,  mxCreateString("nCurbLeft"));
		mxSetCell(mx, 6,  mxCreateString("nCurbRight"));
		mxSetField(struct_inputs, 2, i_names[3], mx);
		mxSetField(plhs[0], 0, names[0], struct_inputs);
		struct_outputs = mxCreateStructMatrix(1,1,7,o_names);
		mxSetField(struct_outputs, 0, o_names[0], mxCreateDoubleScalar(1));
		mxSetField(struct_outputs, 0, o_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_outputs, 0, o_names[2], mxCreateString("constraintvalue"));
		mxSetField(struct_outputs, 0, o_names[4], mxCreateString("VALUE"));
		mx = mxCreateDoubleMatrix(1, 19, mxREAL);
		jac_hess = mxGetPr(mx);
		jac_hess[0] = 0.000000;
		jac_hess[1] = 0.000000;
		jac_hess[2] = 0.000000;
		jac_hess[3] = 0.000000;
		jac_hess[4] = 0.000000;
		jac_hess[5] = 0.000000;
		jac_hess[6] = 0.000000;
		jac_hess[7] = 0.000000;
		jac_hess[8] = 1.000000;
		jac_hess[9] = 0.000000;
		jac_hess[10] = 0.000000;
		jac_hess[11] = 0.000000;
		jac_hess[12] = 0.000000;
		jac_hess[13] = 0.000000;
		jac_hess[14] = 0.000000;
		jac_hess[15] = 0.000000;
		jac_hess[16] = 0.000000;
		jac_hess[17] = 1.000000;
		jac_hess[18] = 1.000000;
		mxSetField(struct_outputs, 0, o_names[5], mx);
		mx = mxCreateDoubleMatrix(0, 0, mxREAL);
		jac_hess = mxGetPr(mx);
		mxSetField(struct_outputs, 0, o_names[6], mx);
		mx = mxCreateCellMatrix(1, 1);
		mxSetCell(mx, 0,  mxCreateString("constraintvaluetmp"));
		mxSetField(struct_outputs, 0, o_names[3], mx);
		mxSetField(plhs[0], 0, names[1], struct_outputs);
		struct_info = mxCreateStructMatrix(1,1,4,info_names);
		mxSetField(struct_info, 0, info_names[0], mxCreateString("20-Jun-2020 13:12:33"));
		mxSetField(struct_info, 0, info_names[1], mxCreateString("fabianhf"));
		mxSetField(struct_info, 0, info_names[2], mxCreateString("9.7.0.1319299 (R2019b) Update 5"));
		mxSetField(struct_info, 0, info_names[3], mxCreateLogicalScalar(false));
		mxSetField(plhs[0], 0, names[2], struct_info);
		return;
	}
	
	// Check Number of Input Arguments
	if (nrhs < 3 || nrhs > 3) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Wrong number of input arguments for fm_mex_tracklimits. The required number of input arguments is 3. Call the mex file with no input arguments to get exact input & output type information.");
	}
	
	// Extract Inputs
	outputs = mxGetPr(prhs[0]);
	states = mxGetPr(prhs[1]);
	controls = mxGetPr(prhs[2]);
	nEval = mxGetN(prhs[0]);
	
	// Check Input Dimensions
	// Input_1: outputs
	if (mxGetM(prhs[0]) != DIM_M_OUTPUTS) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of rows for input 1 with name \"outputs\" should be 4 but is %i.", mxGetM(prhs[0]));
	}
	if (mxGetN(prhs[0]) != nEval) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of columns for input 1 with name \"outputs\" should be equal to the number of time steps (%i) but is %i.", nEval, mxGetN(prhs[0]));
	}
	// Input_2: states
	if (mxGetM(prhs[1]) != DIM_M_STATES) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of rows for input 2 with name \"states\" should be 8 but is %i.", mxGetM(prhs[1]));
	}
	if (mxGetN(prhs[1]) != nEval) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of columns for input 2 with name \"states\" should be equal to the number of time steps (%i) but is %i.", nEval, mxGetN(prhs[1]));
	}
	// Input_3: controls
	if (mxGetM(prhs[2]) != DIM_M_CONTROLS) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of rows for input 3 with name \"controls\" should be 7 but is %i.", mxGetM(prhs[2]));
	}
	if (mxGetN(prhs[2]) != nEval) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of columns for input 3 with name \"controls\" should be equal to the number of time steps (%i) but is %i.", nEval, mxGetN(prhs[2]));
	}
	
	// Prepare jacobian and hessian dimensions
	// Output_1: constraintvalue
	plhs[0] = mxCreateDoubleMatrix(1, 1*nEval, mxREAL);
	constraintvalue = mxGetPr(plhs[0]);
	// Output_jacobian_1: constraintvalue
	j_dim_constraintvalue[0] = NUM_OUT_CONSTRAINTVALUE;
	j_dim_constraintvalue[1] = N_IDP;
	j_dim_constraintvalue[2] = nEval;
	plhs[1] = mxCreateNumericArray(3,j_dim_constraintvalue,mxDOUBLE_CLASS,mxREAL);
	j_constraintvalue = mxGetPr(plhs[1]);
	
	// Call Model in for-loop
	for (int iEval = 0; iEval < nEval; iEval++) {
		mb_fm_mex_tracklimits(
		&outputs[DIM_M_OUTPUTS * iEval],
		&states[DIM_M_STATES * iEval],
		&controls[DIM_M_CONTROLS * iEval],
		&constraintvalue[NUM_OUT_CONSTRAINTVALUE * iEval],
		&j_constraintvalue[NUM_OUT_CONSTRAINTVALUE * N_IDP * iEval]
		);
	}
	// Remove Temporary Variables - Variable Size Data
	
}
// End of File