/*
 * 			AlarmEnable.v
 -----------------------------------

 This module monitors the current time on clock 
 and enables the alarm. The Alarm LED (LED 0) is 
 turned ON for 2 min.
 
 -----------------------------------
 *  	Created on: 30 April 2023
 *      Author: Lohitha Lakshmi Guggilam
 */



module AlarmEnable(

	input clk,	
	input [5:0]alarm_hour,
	input [5:0]alarm_min,
	input switch_enable,
	input [5:0] current_hour,
	input [5:0] current_min,
	
	output reg alarm_enable_LED,
	output reg alarm_LED
	
);


	always @(posedge clk) begin
	
		//Check if Alarm is Enabled
		if(switch_enable) begin
			
			alarm_enable_LED = 1;
			//Checking if Current Time is equal to Alarm Time
			if ((current_hour == alarm_hour) && (current_min == alarm_min)) begin
				//Turning ON alarm LED
				alarm_LED = 1;
			end
			//Check time for 2 min after alarm time
			if ((current_hour == alarm_hour) && (current_min == alarm_min + 6'b000010)) begin
				//alarm LED is turned OFF
				alarm_LED = 0;
			end
		
		end
		else begin
			//The Enable LED is turned OFF
			alarm_enable_LED = 0;
			alarm_LED = 0;
		end

	end


endmodule
