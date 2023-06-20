`timescale 1ns / 100ps   // Timescale

module RealTimeClock_tb;

    // Inputs
    reg clk_50MHz;
	reg mode;
	reg [1:0] pushKey;
	
    // Outputs
    wire clk_1Hz;
	wire [5:0] hour_counter, min_counter, sec_counter;
	
    RealTimeClock RTC_dut (
        .clk_50MHz(clk_50MHz),
		.mode(mode),
		.pushKey(pushKey),
		
		.clk_1Hz(clk_1Hz),
		.hour_counter(hour_counter),
		.min_counter(min_counter),
		.sec_counter(sec_counter)
		
	);

    // Initialize clock
	initial begin
		clk_50MHz = 0;
		mode = 0;
		pushKey = 3;
		
		forever #1 clk_50MHz = ~clk_50MHz;
    end
	
	// Monitor 1Hz signal
	always @(posedge clk_1Hz) begin
		mode = 1;
		#1000;
		pushKey = 2'b10;
		#1000;
		pushKey = 2'b01;
		#1000;
		pushKey = 2'b11;
		#1000;
		mode = 0;
		
		$monitor("SimTime= %d \t 1HzClock = %d \t hour=%d\tminute=%d\tseconds=%d \t ",$time,clk_1Hz,hour_counter,min_counter,sec_counter);
	end

endmodule