function finalRad= ExampleControlProgram(serPort)

   
    maxDuration= 1200;  % Max time to allow the program to run (s)
    maxFwdVel= 0.5;     % Max allowable forward velocity with no angular   
    
    
    tStart= tic;        % Time limit marker
   
    
    while toc(tStart) < maxDuration
        
        
        % 1 - right, 2 - front, 3 - left
        front = ReadSonarMultiple(serPort,2);
        right = ReadSonarMultiple(serPort,1);
        left = ReadSonarMultiple(serPort,3);
        if length([right; front; left])==3
            
        fis = readfis('FUZZY.fis');
        evalfis([front right left],fis)
            
            
            
            SetDriveWheelsCreate(serPort,ans(1),ans(2));
        else
            SetDriveWheelsCreate(serPort,-0.5,0.5);
        end
        [x y th]= OverheadLocalizationCreate(serPort);
        plot(x,y,'r*');
        
        pause(0.1)
    end
    
    
    finalRad= 0;

    SetFwdVelAngVelCreate(serPort,0,0)
end