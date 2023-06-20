/*
 * LT24 Test Pattern Top
 * ------------------------
 * By: Thomas Carpenter
 * For: University of Leeds
 * Date: 13th February 2019
 *
 * Change Log
 * ----------
 *  1.0 - Initial Design
 *  1.1 - Correct xAddr/yAddr pipe-lining to be in sync with pixelData.
 *
 * Short Description
 * -----------------
 * This module is designed to interface with the LT24 Display Module
 * from Terasic. It makes use of the LT24Display IP core to show the real 
 * time clock in HH:MM format
 *
 */

module LT24Top (  
    // Global Clock/Reset
    // - 50Hz Clock
    input              clock,
    // - Enable LCD
    input              enableLCD,
	 // - Real time values
	 input [3:0] valueHr1, valueHr0, valueMin1, valueMin0,
	 
    // - Application Reset - for debug
    output             resetApp,
    
    // LT24 Interface
    output             LT24Wr_n,
    output             LT24Rd_n,
    output             LT24CS_n,
    output             LT24RS,
    output             LT24Reset_n,
    output 		 [15:0] LT24Data,
    output             LT24LCDOn,
	 output [127:0] oi
);

//
// Local Variables
//
reg  [ 7:0] xAddr;
reg  [ 8:0] yAddr;
reg  [15:0] pixelData;
wire        pixelReady;
reg         pixelWrite;

//
// LCD Display
//
localparam LCD_WIDTH  = 240;
localparam LCD_HEIGHT = 320;
integer i = 0;
reg [143:0] charData [0:511];
reg [31:0] ram0 [0:31];
reg [31:0] ram1 [0:31];
reg [31:0] ram2 [0:31];
reg [31:0] ram3 [0:31];
reg [31:0] ram4 [0:31];
reg [31:0] ram5 [0:31];
reg [31:0] ram6 [0:31];
reg [31:0] ram7 [0:31];
reg [31:0] ram8 [0:31];
reg [31:0] ram9 [0:31];
reg [15:0] ramColon [0:31];

//Assign binary files to ran chunks.
initial begin
	$readmemb("zero.txt", ram0);
	$readmemb("one.txt", ram1);
	$readmemb("two.txt", ram2);
	$readmemb("three.txt", ram3);
	$readmemb("four.txt", ram4);
	$readmemb("five.txt", ram5);
	$readmemb("six.txt", ram6);
	$readmemb("seven.txt", ram7);
	$readmemb("eight.txt", ram8);
	$readmemb("nine.txt", ram9);
	$readmemb("colon.txt", ramColon);
	for (i = 0; i <= 31; i = i+1) begin
			charData[i][143:0] = 144'b0;
		end
end



LT24Display #(
    .WIDTH       (LCD_WIDTH  ),
    .HEIGHT      (LCD_HEIGHT ),
    .CLOCK_FREQ  (50000000   )
) Display (
    //Clock and Enable LCD flag
    .clock       (clock      ),
    .globalReset (~enableLCD),
    //Reset for User Logic
    .resetApp    (resetApp   ),
    //Pixel Interface
    .xAddr       (xAddr      ),
    .yAddr       (yAddr      ),
    .pixelData   (pixelData  ),
    .pixelWrite  (pixelWrite ),
    .pixelReady  (pixelReady ),
    //Use pixel addressing mode
    .pixelRawMode(1'b0       ),
    //Unused Command Interface
    .cmdData     (8'b0       ),
    .cmdWrite    (1'b0       ),
    .cmdDone     (1'b0       ),
    .cmdReady    (           ),
    //Display Connections
    .LT24Wr_n    (LT24Wr_n   ),
    .LT24Rd_n    (LT24Rd_n   ),
    .LT24CS_n    (LT24CS_n   ),
    .LT24RS      (LT24RS     ),
    .LT24Reset_n (LT24Reset_n),
    .LT24Data    (LT24Data   ),
    .LT24LCDOn   (LT24LCDOn  )
);

//
// X Counter
//
reg [7:0] xCount;
always @ (posedge clock) begin
	if (resetApp) begin
		xCount <= 8'b0;
	end else if (pixelReady) begin
			if(xCount < (LCD_WIDTH-1)) begin
				xCount <= xCount + 8'd1;
			end else begin
				xCount <= 8'b0;
			end
		 end
end

//
// Y Counter
// Increase the counter ONLY when xCount has reached LCD_WIDTH
reg [8:0] yCount;
always @ (posedge clock) begin
	if (resetApp) begin
		yCount <= 9'b0;
	end else if ((xCount == (LCD_WIDTH-1)) && pixelReady) begin
			if(yCount < (LCD_HEIGHT - 1)) begin
				yCount <= yCount + 9'd1;
			end else begin
				yCount <= 9'b0;
			end
		 end
end

//
// Pixel Write
//
always @ (posedge clock) begin
    if (resetApp) begin
        pixelWrite <= 1'b0;
    end else begin
        //In this example we always set write high, and use pixelReady to detect when
        //to update the data.
        pixelWrite <= 1'b1;
    end
end


//
// Drawing pixels as per the hour and minute values passed from the top module.
//
always @ (posedge clock) begin
    if (resetApp) begin
        pixelData           <= 16'b0;
        xAddr               <= 8'b0;
        yAddr               <= 9'b0;
    end else if (pixelReady) begin
        xAddr               <= xCount;
        yAddr               <= yCount;		  
		  
		pixelData[15:0] <=  16'b0;
		 if ((xAddr>=48) && (xAddr<192) && (yAddr>=144) && (yAddr<177))begin // draw complete row of pixels for all the characters in line						
			if ((charData[yAddr-144][xAddr-48] == 1'b1))begin  // test the current bit using the counters
                pixelData[15:0] <=  16'hFFE0; // yellow - draw pixel if the current bit is 1 as defined
			end
		 else begin
            pixelData[15:0] <=  16'h0000; // else black
        end
		 end else begin
       pixelData[15:0] <=  16'h0000;
      end
			
    end
end


//
// Set time values to charData register which then used by LCD to set colour at particular locations
//
always @(resetApp or pixelReady or valueHr1 or valueHr0 or valueMin1 or valueMin0) begin
	i = 0;
	if (resetApp) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:0] = 144'b0;	
		end
	end
	else if (pixelReady) begin	 
	for (i = 0; i <=31; i = i+1) begin
			charData[i][143:0] = 144'b0;	
		end
	
	// Set Hr MSB
	if(valueHr1 <= 4'b0) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram0[i];			
		end
	end	
	else if (valueHr1 <= 4'b0001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram1[i];			
		end
	end 
	else if (valueHr1 <= 4'b0010) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram2[i];			
		end
	end
	else if (valueHr1 <= 4'b0011) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram3[i];			
		end
	end
	else if (valueHr1 <= 4'b0100) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram4[i];			
		end
	end
	else if (valueHr1 <= 4'b0101) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram5[i];			
		end
	end
	else if (valueHr1 <= 4'b0110) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram6[i];			
		end
	end
	else if (valueHr1 <= 4'b0111) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram7[i];			
		end
	end
	else if (valueHr1 <= 4'b1000) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram8[i];			
		end
	end
	else if (valueHr1 <= 4'b1001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][31:0] = ram9[i];			
		end
	end
	
	
	//Set Hr LSB
	if(valueHr0 <= 4'b0) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram0[i];			
		end
	end	
	else if (valueHr0 <= 4'b0001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram1[i];			
		end
	end 
	else if (valueHr0 <= 4'b0010) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram2[i];			
		end
	end
	else if (valueHr0 <= 4'b0011) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram3[i];			
		end
	end
	else if (valueHr0 <= 4'b0100) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram4[i];			
		end
	end
	else if (valueHr0 <= 4'b0101) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram5[i];			
		end
	end
	else if (valueHr0 <= 4'b0110) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram6[i];			
		end
	end
	else if (valueHr0 <= 4'b0111) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram7[i];			
		end
	end
	else if (valueHr0 <= 4'b1000) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram8[i];			
		end
	end
	else if (valueHr0 <= 4'b1001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][63:32] = ram9[i];			
		end
	end
	
	// Set Colon
	for (i = 0; i <=31; i = i+1) begin
			charData[i][79:64] = ramColon[i];			
		end
	
	// Set Min MSB
	if(valueMin1 <= 4'b0) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram0[i];			
		end
	end	
	else if (valueMin1 <= 4'b0001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram1[i];			
		end
	end 
	else if (valueMin1 <= 4'b0010) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram2[i];			
		end
	end
	else if (valueMin1 <= 4'b0011) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram3[i];			
		end
	end
	else if (valueMin1 <= 4'b0100) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram4[i];			
		end
	end
	else if (valueMin1 <= 4'b0101) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram5[i];			
		end
	end
	else if (valueMin1 <= 4'b0110) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram6[i];			
		end
	end
	else if (valueMin1 <= 4'b0111) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram7[i];			
		end
	end
	else if (valueMin1 <= 4'b1000) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram8[i];			
		end
	end
	else if (valueMin1 <= 4'b1001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][111:80] = ram9[i];			
		end
	end
	
	//Set Min LSB
	if(valueMin0 <= 4'b0) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram0[i];			
		end
	end	
	else if (valueMin0 <= 4'b0001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram1[i];			
		end
	end 
	else if (valueMin0 <= 4'b0010) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram2[i];			
		end
	end
	else if (valueMin0 <= 4'b0011) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram3[i];			
		end
	end
	else if (valueMin0 <= 4'b0100) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram4[i];			
		end
	end
	else if (valueMin0 <= 4'b0101) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram5[i];			
		end
	end
	else if (valueMin0 <= 4'b0110) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram6[i];			
		end
	end
	else if (valueMin0 <= 4'b0111) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram7[i];			
		end
	end
	else if (valueMin0 <= 4'b1000) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram8[i];			
		end
	end
	else if (valueMin0 <= 4'b1001) begin
		for (i = 0; i <=31; i = i+1) begin
			charData[i][143:112] = ram9[i];			
		end
	end
	
 end 
end

endmodule
