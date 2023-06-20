/*
	Real Time Clock
	--------------------
	Use the ClockDivider module that generates a 1Hz pulse to
	calculate HH:MM::SS 24 hour time format 
*/

module RealTimeClock (
	input clk_50MHz,      // 1Hz clock from ClockDivider module
	input mode,
	input [1:0] pushKey,		// 1:HH , 0:MM
	
	output reg clk_1Hz,
	output reg [5:0] hour_counter, min_counter, sec_counter
 );

reg [24:0] count50MHz;
//reg clk_1Hz;

initial begin
	hour_counter = 0;      // Hours counter
	min_counter = 0;     // Minutes counter
	sec_counter = 0;     // Seconds counter

	clk_1Hz = 0;
	count50MHz = 0;
end

// generates a 1Hz clock signal
always @(posedge clk_50MHz) begin
  if (count50MHz == 25000000) begin
    count50MHz <= 0;
    clk_1Hz <= ~clk_1Hz;
  end 
else begin
    count50MHz <= count50MHz + 1;
  end
end


always @(posedge clk_1Hz) begin
	// seconds counter- will increment every seconds. resets to 0 after 60 seconds
	if (sec_counter == 59) begin
		sec_counter<= 0;
	end
	else begin
		sec_counter <= sec_counter+1;
	end
	
	// minutes counter- will increment only after 59 seconds. resets to 0 after 60 minutes
	if ( (min_counter == 59) && (sec_counter == 59) ) 
	begin
		min_counter<= 0;
	end
	else if ( (sec_counter == 59) || ((mode == 1) && (pushKey[0] == 0)) ) 
	begin
		if ( (min_counter < 59) && ((mode == 1) && (pushKey[0] == 0)) ) begin
			min_counter <= min_counter+1;
		end
		else if ( (min_counter == 59) && ((mode == 1) && (pushKey[0] == 0)) ) begin
			min_counter <= 0;		// prevent from going over 59
		end
		else begin
		min_counter <= min_counter+1;
		end
	end
	
	// hours counter- will increment only after 59 minutes. resets to 0 after 23 hours
	if (hour_counter == 23 && (min_counter == 59) && (sec_counter == 59)) begin
		hour_counter<= 0;
	end
	else if( ((min_counter == 59) && (sec_counter == 59)) || ((mode == 1) && (pushKey[1] == 0)) ) begin
		if ( (hour_counter < 23) && ((mode == 1) && (pushKey[1] == 0)) ) begin
			hour_counter <= hour_counter+1;
		end
		else if ( (hour_counter == 23) && ((mode == 1) && (pushKey[1] == 0)) ) begin
			hour_counter <= 0;		// prevent from going over 23
		end
		else begin
		hour_counter <= hour_counter+1;
		end
	end
end

endmodule
