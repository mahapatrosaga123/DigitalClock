`timescale 1ns / 100ps   // Timescale definition for simulation

module DisplaySegment_tb;

    // Inputs
    reg [5:0] hexSeg;
	reg [3:0] valueIn0, valueIn1, valueIn2, valueIn3, valueIn4, valueIn5;
	//reg clock;

    // Outputs
    wire [6:0] D_HSeg0, D_HSeg1, D_HSeg2, D_HSeg3, D_HSeg4, D_HSeg5;
	
	
    DisplaySegment disp7seg_dut (
	
		.hexSeg(hexSeg),
		.valueIn0(valueIn0),
		.valueIn1(valueIn1),
		.valueIn2(valueIn2),
		.valueIn3(valueIn3),
		.valueIn4(valueIn4),
		.valueIn5(valueIn5),
		.D_HSeg0(D_HSeg0), 
		.D_HSeg1(D_HSeg1),
		.D_HSeg2(D_HSeg2),
		.D_HSeg3(D_HSeg3),
		.D_HSeg4(D_HSeg4),
		.D_HSeg5(D_HSeg5)
	);

    // Initialize clock
    /*initial begin
        clock = 0;	
		forever #50 clock = !clock;  // 100ns clock period	
    end
*/

    // Monitor
    initial begin
	
		//Print to console that the simulation has started.
		$display("%d ns\tSimulation Started",$time);
		
		//Monitor changes to values listed, and print to the console when they change.
		$monitor("HEX0=%d\tHEX1=%d\tHEX2=%d\tHEX3=%d\tHEX4=%d\tHEX5=%d\t",D_HSeg0,D_HSeg1,D_HSeg2,D_HSeg3,D_HSeg4,D_HSeg5);
		
		hexSeg=0;
		hexSeg[0] = 1;
		valueIn0= 4'h5;
		#10;
		hexSeg=0;
		hexSeg[1] = 1;
		valueIn1= 4'h4;
		#10;
		hexSeg=0;
		hexSeg[2] = 1;
		valueIn2= 4'h3;
		#10;
		hexSeg=0;
		hexSeg[3] = 1;
		valueIn3= 4'h2;
		#10;
		hexSeg=0;
		hexSeg[4] = 1;
		valueIn4= 4'h8;
		#10;
		hexSeg=0;
		hexSeg[5] = 1;
		valueIn5= 4'h0;  
    end

endmodule