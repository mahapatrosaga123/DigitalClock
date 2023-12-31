/*
 * 			AlarmSet Testbench
 -----------------------------------
 
 This is a testbench file to 
 pass on the alarm time values
 -----------------------------------
 *  	Created on: 7 May 2023
 *      Author: Lohitha Lakshmi Guggilam
 */

`timescale 1 ns/100 ps

 module AlarmSet_tb;

	//Signals for input generated by test bench
	reg clk;
	reg key_hour;
	reg key_min;
	reg switch_set;

	// DUT Output Signals
	wire set_LED;
	wire hour_LED;
	wire min_LED;
	wire [5:0] alarm_hour;
	wire [5:0] alarm_min;


	// Device Under Test Instantiation
	AlarmSet AlarmSet_dut(
		.clk(clk),
		.key_hour(key_hour),
		.key_min(key_min),
		.switch_set(switch_set),
		.set_LED(set_LED),
		.hour_LED(hour_LED),
		.min_LED(min_LED),
		.alarm_hour(alarm_hour),
		.alarm_min(alarm_min)
	);
	
	initial begin
	
		clk = 0;
		forever #10 clk=~clk;
	end
	

	//Testbench logic
	initial begin
	  	
		//In Alarm Set Mode
		switch_set = 1;
		#10; 
		//Hour Input
		//Hour Input
		key_hour = 0;
		#10;
		key_hour = 1;
		#10;

		//Min Input
		key_min = 0;
		#10;
		key_min = 1;
		#10;
		//Alarm Set Mode OFF
		switch_set = 0;
		#10; 
	  
	  
	end
    
 endmodule