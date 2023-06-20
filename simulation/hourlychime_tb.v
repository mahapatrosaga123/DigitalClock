module hourlychime_tb;
    
  reg clk_1Hz;
  reg [5:0] hour;
  reg [5:0] minute;
  reg [5:0] second;
  wire LED;
    
	//Device under Test
	
  hourlychime hourlychime_dut (
    .clk_1Hz(clk_1Hz),
    .hour(hour),
    .minute(minute),
    .second(second),
    .LED(LED)
  );
    
  // Generate a clock
  always begin
    #10 
	clk_1Hz = 1; 
    #10 
	clk_1Hz = 0;
  end
    
	//Random test cases to check the working
 
  initial begin
    
    hour = 0;
    minute = 0;
    second = 0;
    #100;
	
    hour = 1;
    minute = 0;
    second = 0;
    #100;
	
    hour = 3;
    minute = 0;
    second = 0;
    #100;
        
    hour = 2;
    minute = 0;
    second = 0;
    #100;
        
    hour = 8;
    minute = 38;
    second = 0;
    #100;
        
    hour = 12;
    minute = 15;
    second = 0;
    #100;
        
    // End of simulation
    $finish;
  end

endmodule
