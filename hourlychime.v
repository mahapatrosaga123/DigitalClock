module hourlychime (  
// Declare ports
	input clk_1Hz,
	input [5:0] hour,
	input [5:0] minute,
	input [5:0] second,
	
	
	output reg LED
);

reg [5:0] chime_hour;
reg [5:0] chime_counter;
reg chime_enable;

initial begin
	chime_hour = 0;
	chime_counter = 0;
	chime_enable = 0;
	LED = 0;
end

always @(posedge clk_1Hz) begin
    if ( (second == 0) && (minute == 0) ) begin 
		if (hour == 0) begin
			chime_hour = 6'd12;         //At zeroth hour it will chime 12 times
		end
		else if (hour <= 12) begin
			chime_hour = hour;
		end
		else if (hour > 12) begin 
			chime_hour = hour - 6'd12;  //After the 12th hour the chime will happen hour - 12 times
		end
		chime_enable = 1;
		chime_hour = chime_hour * 2;
	end

    if ( (chime_counter < chime_hour) && (chime_enable == 1) ) begin //Blink the LED when chime_enable is high
		LED = ~LED;
		chime_counter = chime_counter + 1;
	end
	else begin
		LED = 0;
		chime_counter = 0;
		chime_enable = 0;
	end
end

endmodule
