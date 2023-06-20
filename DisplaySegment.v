/*
	7 Segment Display
	--------------------
	converting numbers to on the 7 segment display values.
	
	--------------------
	hexSeg: input to decide which segment to display on
	valueIn: Value to be displayed on the segment
	D_HSeg: Outputs the LED segments to be high to display value
*/

module DisplaySegment(
	input [5:0] hexSeg,			// HEX enable 
	input [3:0] valueIn0, valueIn1, valueIn2, valueIn3, valueIn4, valueIn5, 	// value to be displayed on the 7-segment
	output reg [6:0] D_HSeg0, D_HSeg1, D_HSeg2, D_HSeg3, D_HSeg4, D_HSeg5	//  active high values as o/p to HEX0-5
	
	); 

integer i;

// HEX0
always @*
begin
	if (hexSeg[0] == 1) begin
		case (valueIn0)
			4'b0001: D_HSeg0 =~7'b0110000;	// 1
			4'b0000: D_HSeg0 =~7'b1111110;	// 0
			4'b0010: D_HSeg0 =~7'b1101101;	// 2
			4'b0011: D_HSeg0 =~7'b1111001;	// 3
			4'b0100: D_HSeg0 =~7'b0110011;	// 4
			4'b0101: D_HSeg0 =~7'b1011011;	// 5
			4'b0110: D_HSeg0 =~7'b1011111;	// 6
			4'b0111: D_HSeg0 =~7'b1110000;	// 7
			4'b1000: D_HSeg0 =~7'b1111111;	// 8
			4'b1001: D_HSeg0 =~7'b1111011;	// 9
			default: D_HSeg0 =~7'b0000000;	// blank
		endcase
	end
end

// HEX1
always @*
begin
	if (hexSeg[1] == 1) begin
		case (valueIn1)
			4'b0001: D_HSeg1 =~7'b0110000;	// 1
			4'b0000: D_HSeg1 =~7'b1111110;	// 0
			4'b0010: D_HSeg1 =~7'b1101101;	// 2
			4'b0011: D_HSeg1 =~7'b1111001;	// 3
			4'b0100: D_HSeg1 =~7'b0110011;	// 4
			4'b0101: D_HSeg1 =~7'b1011011;	// 5
			4'b0110: D_HSeg1 =~7'b1011111;	// 6
			4'b0111: D_HSeg1 =~7'b1110000;	// 7
			4'b1000: D_HSeg1 =~7'b1111111;	// 8
			4'b1001: D_HSeg1 =~7'b1111011;	// 9
			default: D_HSeg1 =~7'b0000000;	// blank
		endcase
	end
end

//HEX2
always @*
begin
	if (hexSeg[2] == 1) begin
		case (valueIn2)
			4'b0001: D_HSeg2 =~7'b0110000;	// 1
			4'b0000: D_HSeg2 =~7'b1111110;	// 0
			4'b0010: D_HSeg2 =~7'b1101101;	// 2
			4'b0011: D_HSeg2 =~7'b1111001;	// 3
			4'b0100: D_HSeg2 =~7'b0110011;	// 4
			4'b0101: D_HSeg2 =~7'b1011011;	// 5
			4'b0110: D_HSeg2 =~7'b1011111;	// 6
			4'b0111: D_HSeg2 =~7'b1110000;	// 7
			4'b1000: D_HSeg2 =~7'b1111111;	// 8
			4'b1001: D_HSeg2 =~7'b1111011;	// 9
			default: D_HSeg2 =~7'b0000000;	// blank
		endcase
	end
end

//HEX3
always @*
begin
	if (hexSeg[3] == 1) begin
		case (valueIn3)
			4'b0001: D_HSeg3 =~7'b0110000;	// 1
			4'b0000: D_HSeg3 =~7'b1111110;	// 0
			4'b0010: D_HSeg3 =~7'b1101101;	// 2
			4'b0011: D_HSeg3 =~7'b1111001;	// 3
			4'b0100: D_HSeg3 =~7'b0110011;	// 4
			4'b0101: D_HSeg3 =~7'b1011011;	// 5
			4'b0110: D_HSeg3 =~7'b1011111;	// 6
			4'b0111: D_HSeg3 =~7'b1110000;	// 7
			4'b1000: D_HSeg3 =~7'b1111111;	// 8
			4'b1001: D_HSeg3 =~7'b1111011;	// 9
			default: D_HSeg3 =~7'b0000000;	// blank
		endcase
	end
end

//HEX4
always @*
begin
	if (hexSeg[4] == 1) begin
		case (valueIn4)
			4'b0001: D_HSeg4 =~7'b0110000;	// 1
			4'b0000: D_HSeg4 =~7'b1111110;	// 0
			4'b0010: D_HSeg4 =~7'b1101101;	// 2
			4'b0011: D_HSeg4 =~7'b1111001;	// 3
			4'b0100: D_HSeg4 =~7'b0110011;	// 4
			4'b0101: D_HSeg4 =~7'b1011011;	// 5
			4'b0110: D_HSeg4 =~7'b1011111;	// 6
			4'b0111: D_HSeg4 =~7'b1110000;	// 7
			4'b1000: D_HSeg4 =~7'b1111111;	// 8
			4'b1001: D_HSeg4 =~7'b1111011;	// 9
			default: D_HSeg4 =~7'b0000000;	// blank
		endcase
	end
end

//HEX5
always @*
begin
	if (hexSeg[5] == 1) begin
		case (valueIn5)
			4'b0001: D_HSeg5 =~7'b0110000;	// 1
			4'b0000: D_HSeg5 =~7'b1111110;	// 0
			4'b0010: D_HSeg5 =~7'b1101101;	// 2
			4'b0011: D_HSeg5 =~7'b1111001;	// 3
			4'b0100: D_HSeg5 =~7'b0110011;	// 4
			4'b0101: D_HSeg5 =~7'b1011011;	// 5
			4'b0110: D_HSeg5 =~7'b1011111;	// 6
			4'b0111: D_HSeg5 =~7'b1110000;	// 7
			4'b1000: D_HSeg5 =~7'b1111111;	// 8
			4'b1001: D_HSeg5 =~7'b1111011;	// 9
			default: D_HSeg5 =~7'b0000000;	// blank
		endcase
	end
end

endmodule