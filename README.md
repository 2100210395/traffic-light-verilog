# traffic-light-verilog
A Verilog-based Traffic Light Controller with testbench and simulation.

Consider a controller for traffic at the intersection of a main highway and a 
country road.
State    Signals 
SO    Hwy = G Cntry = R 
S1    Hwy = Y Cntry = R 
S2    Hwy = R Cntry = R 
S3    Hwy=RCntry=G 
S4    Hwy=RCntry=Y 

Specifications:

1.The traffic signal for the main highway gets highest priority because cars are 
continuously present on the main highway. Thus, the main highway signal 
remains green by default. 

2.Occasionally, cars from the country road arrive at the traffic signal. The 
traffic signal for the country road must turn green only long enough to let 
the cars on the country road go. 

3.As soon as there are no cars on the country road, the country road traffic 
signal turns yellow and then red and the traffic signal on the main highway 
turns green again. 

4.There is a sensor to detect cars waiting on the country road. The sensor 
sends a signal X as input to the controller. X = 1 if there are cars on the 
country road; otherwise, X= 0 . 

5.There are delays on transitions from S1 to 52, from S2 to S3, and from S4 to 
SO. The delays must be controllable. 

The state machine diagram and the state definitions for the traffic signal 
controller are shown in Figure below. 
