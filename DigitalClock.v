module DigitalClock(
	input clk_50MHz,
	(* chip_pin = "AE12, AD10, AC9, AE11, AD12, AD11, AF10, AF9, AC12, AB12" *)
	input [9:0] slideSw,
	(* chip_pin = "Y16, W15, AA15, AA14" *)
	input [3:0] pushKey,	
	(* chip_pin = "Y21, W21, W20, Y19, W19, W17, V18, V17, W16, V16" *)
	output [9:0] led,
	// LCD input/outputs	
	(* chip_pin = "AH17" *)
	output LT24Wr_n,
	(* chip_pin = "AH18" *)
	output LT24Rd_n,
	(* chip_pin = "AD20" *)
	output LT24CS_n,
	(* chip_pin = "AG16" *)
	output LT24RS,
	(* chip_pin = "AG20" *)
	output LT24Reset_n,
	(* chip_pin = "AJ21" *)
	output LT24LCDOn,
	(* chip_pin = "AD19, AK21, AH20, AJ20, AH19, AC20, AE17, AA19, AA18, AG17, AF16, AE16, AK18, AK19, AJ19, AJ17" *)
	output [15:0] LT24Data,	
	
	output wire [6:0] D_S2,D_S1,D_M2,D_M1,D_H2,D_H1
);

wire clk_1Hz ;
wire [17:0] RTC_time;
reg [5:0] Disp_hexSeg;
reg [3:0] Disp_valueIn [0:5];
wire [5:0] alarm_hour, alarm_min;


RealTimeClock rtc(
	.clk_50MHz (clk_50MHz),
	.mode (slideSw[0]),
	.pushKey (pushKey[1:0]),					 
	.clk_1Hz(clk_1Hz),
	.sec_counter(RTC_time[5:0]),
	.min_counter(RTC_time[11:6]),
	.hour_counter(RTC_time[17:12])
);

DisplaySegment time7seg(
	.hexSeg(6'b111111),
	.valueIn0(Disp_valueIn[0]),
	.valueIn1(Disp_valueIn[1]),
	.valueIn2(Disp_valueIn[2]),
	.valueIn3(Disp_valueIn[3]),
	.valueIn4(Disp_valueIn[4]),
	.valueIn5(Disp_valueIn[5]),
	.D_HSeg0(D_S2), 
	.D_HSeg1(D_S1),
	.D_HSeg2(D_M2),
	.D_HSeg3(D_M1),
	.D_HSeg4(D_H2),
	.D_HSeg5(D_H1)
);

AlarmSet setalarm(

	.clk(clk_1Hz),
	.key_hour(pushKey[3]),
	.key_min(pushKey[2]),
	.switch_set(slideSw[2]),
	.alarm_hour(alarm_hour[5:0]),
	.alarm_min(alarm_min[5:0]),
	.hour_LED(led[5]),
	.min_LED(led[4]),
	.set_LED(led[2])

);
hourlychime chime(
   
    .clk_1Hz(clk_1Hz),
    .second(RTC_time[5:0]),
    .minute(RTC_time[11:6]),
    .hour(RTC_time[17:12]),
    .LED(led[9])

);


AlarmEnable onalarm(

	.clk(clk_50MHz),
	.alarm_hour(alarm_hour[5:0]),
	.alarm_min(alarm_min[5:0]),
	.switch_enable(slideSw[3]),
	.current_hour(RTC_time[17:12]),
	.current_min(RTC_time[11:6]),
	.alarm_enable_LED(led[3]),
	.alarm_LED(led[0])

);

LT24Top lcdController(
	.clock(clk_50MHz),
	.enableLCD(slideSw[4]),
	.valueHr1(Disp_valueIn[5]),
	.valueHr0(Disp_valueIn[4]),
	.valueMin1(Disp_valueIn[3]),
	.valueMin0(Disp_valueIn[2]),
	.resetApp(led[1]),
	.LT24Wr_n(LT24Wr_n),
	.LT24Rd_n(LT24Rd_n),
	.LT24CS_n(LT24CS_n),
	.LT24RS(LT24RS),
	.LT24Reset_n(LT24Reset_n),
	.LT24Data(LT24Data),
	.LT24LCDOn(LT24LCDOn)
);


always @*
begin
	Disp_valueIn[0] <= RTC_time[5:0]%10;
	Disp_valueIn[1] <= RTC_time[5:0]/10;
	Disp_valueIn[2] <= RTC_time[11:6]%10;
	Disp_valueIn[3] <= RTC_time[11:6]/10;
	Disp_valueIn[4] <= RTC_time[17:12]%10;
	Disp_valueIn[5] <= RTC_time[17:12]/10;
end

endmodule