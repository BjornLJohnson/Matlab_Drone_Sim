% MEAM 620 Student Multi Waypoint code

if (setitM(qn)~=903) %The variable setitM(qn) tracks what type of sequence each quad is in. 
                     %If the quad switches sequences, this if statement will be active.
    setitM(qn)=903;  %This changes setitM(qn) to the current sequence type so that this code only runs once.

    startTime = GetUnixTime;    
    %PUT ANY INITIALIZATION HERE
    
    
    
    
    %END INTITIALIZATION

end %everything beyond this point runs every control loop iteration

localTime = GetUnixTime - startTime;

%COMPUTE CONTROL HERE