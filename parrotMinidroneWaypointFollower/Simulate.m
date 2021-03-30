

% sim('parrotMinidroneWaypointFollower.slx')
% noise_weight  = Sensors.IMU.noiseWeights
% new_noise_weight = noise_weight+noise_weight*0.05


% mdl = 'parrotMinidroneWaypointFollower'

for i = 1:5
    
    noise_weight  = Sensors.IMU.noiseWeights
    new_noise_weight = noise_weight+noise_weight*0.0
    Sensors.IMU.noiseWeights = new_noise_weight;
    wp= meteorites()
    
    writematrix(wp,'wpSim1.xls','Sheet',i)
    fclose('all')
    waypoint = wp
    
    sim('parrotMinidroneWaypointFollower.slx')
    Data(i).output = output;
end
Save('Simout',Data);

function wp = meteorites()
p= [];
q= [];
wp=[];
point=[];
count= 0;
tempx = 0;
tempy = 0;
for i = 1:20
    angle = unifrnd(0, 2 * pi) ;
    distance = sqrt(unifrnd(4, 12.25));
    x= int8(distance * cos(angle));
    y= int8(distance * sin(angle));
        
    if(x == 0 && y == 0)
        continue
    
    elseif((tempx == x) && (tempy == y))
        continue
    else
        count=count+1;
        tempx = x;
        tempy = y;
        point = cat(2,x,y,-1)
        wp = vertcat(wp,point)
        wp = double(wp)
    end
    
    if count == 5
       wp = vertcat(wp,[0 0 -1])
       break
    end  

end
end


