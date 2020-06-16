// Call Function generated automatically on 16-Jun-2020 19:12:14
// Created on Steffen-PC
#include "mex.h"
#include "math.h"
#include "mb_vehicle_nlp.h"

// Constants - Input Dimensions
#define DIM_M_STATES 7
#define DIM_M_CONTROLS 5

// Constants - Number of Independent Variables (non discrete control case)
#define N_IDP 12

// Constants - Output Sizes
#define NUM_OUT_STATESDOT 7
#define NUM_OUT_OUTPUTS 3

// Function Header
void mexFunction( int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[] ) {
	
	// Define Inputs
	double *states;
	double *controls;
	
	// Declare number of time steps
	int nEval;
	
	// Declare Outputs
	double *statesdot, *j_statesdot;
	mwSize j_dim_statesdot[3];
	double *outputs, *j_outputs;
	mwSize j_dim_outputs[3];
	
	// Write Call Information
	if (nrhs == 0 && nlhs == 0) {
		// System Information
		mexPrintf("<strong>System Information</strong>\n");
		mexPrintf("Mex file created by Derivative Model Builder\n");
		mexPrintf("- Date:                16-Jun-2020 19:12:14\n");
		mexPrintf("- Computer:            Steffen-PC\n");
		mexPrintf("- MATLAB-Version:      9.7.0.1319299 (R2019b) Update 5\n");
		mexPrintf("- Hessian-Calculation: false\n");
		mexPrintf("\n");
		
		// Input Information
		mexPrintf("<strong>Input Information</strong>\n");
		mexPrintf("<strong>Name</strong>     <strong>Size</strong>  <strong>Derivative</strong> <strong>MultipleTimeEval</strong> <strong>VariableSize</strong>\n");
		mexPrintf("states   [7 1]       true             true        false\n");
		mexPrintf("| t\n");
		mexPrintf("| v\n");
		mexPrintf("| psi_dot\n");
		mexPrintf("| beta\n");
		mexPrintf("| n\n");
		mexPrintf("| xi\n");
		mexPrintf("| objective\n");
		mexPrintf("\n");
		mexPrintf("controls [5 1]       true             true        false\n");
		mexPrintf("| delta\n");
		mexPrintf("| fB\n");
		mexPrintf("| zeta\n");
		mexPrintf("| phi\n");
		mexPrintf("| C\n");
		mexPrintf("\n");
		mexPrintf("\n");
		
		// Output Information
		mexPrintf("<strong>Output Information</strong>\n");
		mexPrintf("<strong>Name</strong>      <strong>Size</strong> \n");
		mexPrintf("statesdot [7 1]\n");
		mexPrintf("| t_dot_s\n");
		mexPrintf("| v_dot_s\n");
		mexPrintf("| psi_dot_dot_s\n");
		mexPrintf("| beta_dot_s\n");
		mexPrintf("| n_dot_s\n");
		mexPrintf("| xi_dot_s\n");
		mexPrintf("| objective_dot_s\n");
		mexPrintf("\n");
		mexPrintf("outputs   [3 1]\n");
		mexPrintf("| n_wheel\n");
		mexPrintf("| M_wheel\n");
		mexPrintf("| T_M\n");
		mexPrintf("\n");
		
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
		mxSetField(plhs[0], 0, names[3], mxCreateString("vehicle_nlp"));
		mxSetField(plhs[0], 0, names[4], mxCreateString("SIMULATION_MODEL"));
		struct_inputs = mxCreateStructMatrix(2,1,6,i_names);
		mxSetField(struct_inputs, 0, i_names[0], mxCreateDoubleScalar(7));
		mxSetField(struct_inputs, 0, i_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_inputs, 0, i_names[2], mxCreateString("states"));
		mxSetField(struct_inputs, 0, i_names[4], mxCreateString("STATE"));
		mxSetField(struct_inputs, 0, i_names[5], mxCreateDoubleScalar(0));
		mx = mxCreateCellMatrix(7, 1);
		mxSetCell(mx, 0,  mxCreateString("t"));
		mxSetCell(mx, 1,  mxCreateString("v"));
		mxSetCell(mx, 2,  mxCreateString("psi_dot"));
		mxSetCell(mx, 3,  mxCreateString("beta"));
		mxSetCell(mx, 4,  mxCreateString("n"));
		mxSetCell(mx, 5,  mxCreateString("xi"));
		mxSetCell(mx, 6,  mxCreateString("objective"));
		mxSetField(struct_inputs, 0, i_names[3], mx);
		mxSetField(struct_inputs, 1, i_names[0], mxCreateDoubleScalar(5));
		mxSetField(struct_inputs, 1, i_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_inputs, 1, i_names[2], mxCreateString("controls"));
		mxSetField(struct_inputs, 1, i_names[4], mxCreateString("CONTROL"));
		mxSetField(struct_inputs, 1, i_names[5], mxCreateDoubleScalar(0));
		mx = mxCreateCellMatrix(5, 1);
		mxSetCell(mx, 0,  mxCreateString("delta"));
		mxSetCell(mx, 1,  mxCreateString("fB"));
		mxSetCell(mx, 2,  mxCreateString("zeta"));
		mxSetCell(mx, 3,  mxCreateString("phi"));
		mxSetCell(mx, 4,  mxCreateString("C"));
		mxSetField(struct_inputs, 1, i_names[3], mx);
		mxSetField(plhs[0], 0, names[0], struct_inputs);
		struct_outputs = mxCreateStructMatrix(2,1,7,o_names);
		mxSetField(struct_outputs, 0, o_names[0], mxCreateDoubleScalar(7));
		mxSetField(struct_outputs, 0, o_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_outputs, 0, o_names[2], mxCreateString("statesdot"));
		mxSetField(struct_outputs, 0, o_names[4], mxCreateString("STATEDOT"));
		mx = mxCreateDoubleMatrix(7, 12, mxREAL);
		jac_hess = mxGetPr(mx);
		jac_hess[0] = 0.000000;
		jac_hess[1] = 0.000000;
		jac_hess[2] = 0.000000;
		jac_hess[3] = 0.000000;
		jac_hess[4] = 0.000000;
		jac_hess[5] = 0.000000;
		jac_hess[6] = 0.000000;
		jac_hess[7] = 1.000000;
		jac_hess[8] = 1.000000;
		jac_hess[9] = 1.000000;
		jac_hess[10] = 1.000000;
		jac_hess[11] = 1.000000;
		jac_hess[12] = 1.000000;
		jac_hess[13] = 1.000000;
		jac_hess[14] = 0.000000;
		jac_hess[15] = 1.000000;
		jac_hess[16] = 1.000000;
		jac_hess[17] = 1.000000;
		jac_hess[18] = 0.000000;
		jac_hess[19] = 1.000000;
		jac_hess[20] = 0.000000;
		jac_hess[21] = 1.000000;
		jac_hess[22] = 1.000000;
		jac_hess[23] = 1.000000;
		jac_hess[24] = 1.000000;
		jac_hess[25] = 1.000000;
		jac_hess[26] = 1.000000;
		jac_hess[27] = 1.000000;
		jac_hess[28] = 1.000000;
		jac_hess[29] = 1.000000;
		jac_hess[30] = 1.000000;
		jac_hess[31] = 1.000000;
		jac_hess[32] = 1.000000;
		jac_hess[33] = 1.000000;
		jac_hess[34] = 1.000000;
		jac_hess[35] = 1.000000;
		jac_hess[36] = 1.000000;
		jac_hess[37] = 1.000000;
		jac_hess[38] = 1.000000;
		jac_hess[39] = 1.000000;
		jac_hess[40] = 1.000000;
		jac_hess[41] = 1.000000;
		jac_hess[42] = 0.000000;
		jac_hess[43] = 0.000000;
		jac_hess[44] = 0.000000;
		jac_hess[45] = 0.000000;
		jac_hess[46] = 0.000000;
		jac_hess[47] = 0.000000;
		jac_hess[48] = 0.000000;
		jac_hess[49] = 0.000000;
		jac_hess[50] = 1.000000;
		jac_hess[51] = 1.000000;
		jac_hess[52] = 1.000000;
		jac_hess[53] = 0.000000;
		jac_hess[54] = 0.000000;
		jac_hess[55] = 0.000000;
		jac_hess[56] = 0.000000;
		jac_hess[57] = 1.000000;
		jac_hess[58] = 1.000000;
		jac_hess[59] = 1.000000;
		jac_hess[60] = 0.000000;
		jac_hess[61] = 0.000000;
		jac_hess[62] = 0.000000;
		jac_hess[63] = 0.000000;
		jac_hess[64] = 1.000000;
		jac_hess[65] = 1.000000;
		jac_hess[66] = 1.000000;
		jac_hess[67] = 0.000000;
		jac_hess[68] = 0.000000;
		jac_hess[69] = 0.000000;
		jac_hess[70] = 0.000000;
		jac_hess[71] = 1.000000;
		jac_hess[72] = 0.000000;
		jac_hess[73] = 1.000000;
		jac_hess[74] = 0.000000;
		jac_hess[75] = 0.000000;
		jac_hess[76] = 0.000000;
		jac_hess[77] = 1.000000;
		jac_hess[78] = 1.000000;
		jac_hess[79] = 1.000000;
		jac_hess[80] = 1.000000;
		jac_hess[81] = 1.000000;
		jac_hess[82] = 1.000000;
		jac_hess[83] = 1.000000;
		mxSetField(struct_outputs, 0, o_names[5], mx);
		mx = mxCreateDoubleMatrix(0, 0, mxREAL);
		jac_hess = mxGetPr(mx);
		mxSetField(struct_outputs, 0, o_names[6], mx);
		mx = mxCreateCellMatrix(7, 1);
		mxSetCell(mx, 0,  mxCreateString("t_dot_s"));
		mxSetCell(mx, 1,  mxCreateString("v_dot_s"));
		mxSetCell(mx, 2,  mxCreateString("psi_dot_dot_s"));
		mxSetCell(mx, 3,  mxCreateString("beta_dot_s"));
		mxSetCell(mx, 4,  mxCreateString("n_dot_s"));
		mxSetCell(mx, 5,  mxCreateString("xi_dot_s"));
		mxSetCell(mx, 6,  mxCreateString("objective_dot_s"));
		mxSetField(struct_outputs, 0, o_names[3], mx);
		mxSetField(struct_outputs, 1, o_names[0], mxCreateDoubleScalar(3));
		mxSetField(struct_outputs, 1, o_names[1], mxCreateDoubleScalar(1));
		mxSetField(struct_outputs, 1, o_names[2], mxCreateString("outputs"));
		mxSetField(struct_outputs, 1, o_names[4], mxCreateString("OUTPUT"));
		mx = mxCreateDoubleMatrix(3, 12, mxREAL);
		jac_hess = mxGetPr(mx);
		jac_hess[0] = 0.000000;
		jac_hess[1] = 0.000000;
		jac_hess[2] = 0.000000;
		jac_hess[3] = 1.000000;
		jac_hess[4] = 1.000000;
		jac_hess[5] = 1.000000;
		jac_hess[6] = 0.000000;
		jac_hess[7] = 0.000000;
		jac_hess[8] = 0.000000;
		jac_hess[9] = 0.000000;
		jac_hess[10] = 0.000000;
		jac_hess[11] = 0.000000;
		jac_hess[12] = 0.000000;
		jac_hess[13] = 0.000000;
		jac_hess[14] = 0.000000;
		jac_hess[15] = 0.000000;
		jac_hess[16] = 0.000000;
		jac_hess[17] = 0.000000;
		jac_hess[18] = 0.000000;
		jac_hess[19] = 0.000000;
		jac_hess[20] = 0.000000;
		jac_hess[21] = 0.000000;
		jac_hess[22] = 0.000000;
		jac_hess[23] = 0.000000;
		jac_hess[24] = 0.000000;
		jac_hess[25] = 0.000000;
		jac_hess[26] = 0.000000;
		jac_hess[27] = 0.000000;
		jac_hess[28] = 0.000000;
		jac_hess[29] = 0.000000;
		jac_hess[30] = 0.000000;
		jac_hess[31] = 1.000000;
		jac_hess[32] = 1.000000;
		jac_hess[33] = 0.000000;
		jac_hess[34] = 0.000000;
		jac_hess[35] = 0.000000;
		mxSetField(struct_outputs, 1, o_names[5], mx);
		mx = mxCreateDoubleMatrix(0, 0, mxREAL);
		jac_hess = mxGetPr(mx);
		mxSetField(struct_outputs, 1, o_names[6], mx);
		mx = mxCreateCellMatrix(3, 1);
		mxSetCell(mx, 0,  mxCreateString("n_wheel"));
		mxSetCell(mx, 1,  mxCreateString("M_wheel"));
		mxSetCell(mx, 2,  mxCreateString("T_M"));
		mxSetField(struct_outputs, 1, o_names[3], mx);
		mxSetField(plhs[0], 0, names[1], struct_outputs);
		struct_info = mxCreateStructMatrix(1,1,4,info_names);
		mxSetField(struct_info, 0, info_names[0], mxCreateString("16-Jun-2020 19:12:14"));
		mxSetField(struct_info, 0, info_names[1], mxCreateString("Steffen-PC"));
		mxSetField(struct_info, 0, info_names[2], mxCreateString("9.7.0.1319299 (R2019b) Update 5"));
		mxSetField(struct_info, 0, info_names[3], mxCreateLogicalScalar(false));
		mxSetField(plhs[0], 0, names[2], struct_info);
		return;
	}
	
	// Check Number of Input Arguments
	if (nrhs < 2 || nrhs > 2) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Wrong number of input arguments for vehicle_nlp. The required number of input arguments is 2. Call the mex file with no input arguments to get exact input & output type information.");
	}
	
	// Extract Inputs
	states = mxGetPr(prhs[0]);
	controls = mxGetPr(prhs[1]);
	nEval = mxGetN(prhs[0]);
	
	// Check Input Dimensions
	// Input_1: states
	if (mxGetM(prhs[0]) != DIM_M_STATES) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of rows for input 1 with name \"states\" should be 7 but is %i.", mxGetM(prhs[0]));
	}
	if (mxGetN(prhs[0]) != nEval) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of columns for input 1 with name \"states\" should be equal to the number of time steps (%i) but is %i.", nEval, mxGetN(prhs[0]));
	}
	// Input_2: controls
	if (mxGetM(prhs[1]) != DIM_M_CONTROLS) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of rows for input 2 with name \"controls\" should be 5 but is %i.", mxGetM(prhs[1]));
	}
	if (mxGetN(prhs[1]) != nEval) {
		mexErrMsgIdAndTxt("MATLAB:callModel:Error","Number of columns for input 2 with name \"controls\" should be equal to the number of time steps (%i) but is %i.", nEval, mxGetN(prhs[1]));
	}
	
	// Prepare jacobian and hessian dimensions
	// Output_1: statesdot
	plhs[0] = mxCreateDoubleMatrix(7, 1*nEval, mxREAL);
	statesdot = mxGetPr(plhs[0]);
	// Output_jacobian_1: statesdot
	j_dim_statesdot[0] = NUM_OUT_STATESDOT;
	j_dim_statesdot[1] = N_IDP;
	j_dim_statesdot[2] = nEval;
	plhs[2] = mxCreateNumericArray(3,j_dim_statesdot,mxDOUBLE_CLASS,mxREAL);
	j_statesdot = mxGetPr(plhs[2]);
	
	// Output_2: outputs
	plhs[1] = mxCreateDoubleMatrix(3, 1*nEval, mxREAL);
	outputs = mxGetPr(plhs[1]);
	// Output_jacobian_2: outputs
	j_dim_outputs[0] = NUM_OUT_OUTPUTS;
	j_dim_outputs[1] = N_IDP;
	j_dim_outputs[2] = nEval;
	plhs[3] = mxCreateNumericArray(3,j_dim_outputs,mxDOUBLE_CLASS,mxREAL);
	j_outputs = mxGetPr(plhs[3]);
	
	// Call Model in for-loop
	for (int iEval = 0; iEval < nEval; iEval++) {
		mb_vehicle_nlp(
		&states[DIM_M_STATES * iEval],
		&controls[DIM_M_CONTROLS * iEval],
		&statesdot[NUM_OUT_STATESDOT * iEval],
		&outputs[NUM_OUT_OUTPUTS * iEval],
		&j_statesdot[NUM_OUT_STATESDOT * N_IDP * iEval],
		&j_outputs[NUM_OUT_OUTPUTS * N_IDP * iEval]
		);
	}
	// Remove Temporary Variables - Variable Size Data
	
}
// End of File