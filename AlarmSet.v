/*
 * 			AlarmSet.v
 -----------------------------------
 
 This module sets the alarm time for the clock 
 using 2 push buttons and a set switch
 -----------------------------------
 *  	Created on: 29 April 2023
 *      Author: Lohitha Lakshmi Guggilam
 */


module AlarmSet(

	input clk,	
	input key_hour,
	input key_min,
	input switch_set,
	
	output reg set_LED,
	output reg hour_LED,
	output reg min_LED,
	output reg [5:0] alarm_hour,
	output reg [5:0] alarm_min

);

reg [5:0] count_hour, count_min;

initial begin 
	//Hour and Min Counter values are assigned 0 
	count_hour = 6'b0;
	count_min = 6'b0;

	alarm_hour = 6'b0;
	alarm_min =6'b0;
		
end


always @(posedge clk) begin

		//Hour, Min and Set Alarm LEDs are turned OFF
		set_LED = 0;
		hour_LED = 0;
		min_LED = 0;
	
	if (switch_set == 1) begin	
	
		//Set LED is ON when set switch is ON
		set_LED = 1;
		
		if (key_hour == 0) 
		begin	
			
			//When Hour button is pressed hour counter is increased
			count_hour <= count_hour + 6'b1;
			hour_LED = 1;
			
			//If hour counter is 24, counter is reset
			if (count_hour == 6'b11000) begin				
				count_hour <= 6'b0;			
			end
				
		end
		
		if (key_min == 0) begin
		
			//When Min button is pressed Min counter is increased
			count_min <= count_min + 6'b1;
			min_LED = 1;
			
			//If min counter is 60, counter is reset
			if(count_min == 6'b111100) begin			
				count_min <= 6'b0;	
			end

		end
	
	end
	
	else begin	
	
		//The final hour and min counter values are assigned to Alarm Hour and Min
		
		alarm_hour <= count_hour;
		
		//Min counter values are multiplied by 15 and assigned to Alarm Min
		//alarm_min <= count_min * 6'b1111;
		//For fast demonstration the alarm_min is incremented by 1 min
		alarm_min <= count_min; 
	
	end

end

endmodule
