function StartupCheck()

try
    clc;
    % Initialize to have all folders on path
    falcon.init(true);
    
    % print license agreement
    falcon.auxiliary.helpers.printLicenseAgreement();
    
    % Call the initialization checks
    checkClass = falcon.console.CheckCommand();
    checkClass.call;
    
    addpath(fileparts(mfilename('fullpath')));
    
    % Reinitialize if anything has changed
    falcon.init(true);
    
    disp('See the FALCON.m examples in the folder examples.');
catch
    fprintf(2, '\nCould not run StartUpCheck.\nPlease secure that the Matlab path is correct.\n');
end
end