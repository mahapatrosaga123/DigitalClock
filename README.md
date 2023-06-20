# ELEC5566M Mini-Project Repository

The idea of the project is to run a digital clock in 24-hour format with additional features like alarm, hourly chime, and LCD display to display the running clock. The whole project is divided into four segments.

1) DigitalClock.v : Top module of the project. This module serves as the entry point where instantiation of below modules are done. Pin assignments are done using Verilog attributes.

2) RealTimeClock.v : This module is used to generate real time clock with three counters namely seconds, minutes, and hours. It is designed in such a way that it can take inputs from switches to set the mode and push buttons are used to set the time. This can also show real time clock on the seven-segment display.

3) AlarmSet.v : This module allows the user to set the alarm time using key inputs for the hour and minute values. It includes LEDs to indicate the setting mode and displays the set alarm time. The module uses registers to store the count values for the hour and minute. When the setting mode is active, the count values are incremented based on the key inputs. Once the desired alarm time is set, the module stores the values in the alarm_hour and alarm_min registers.

4) AlarmEnable.v : This module is responsible for enabling and activating the alarm based on the set alarm time. It includes LED indicators to display the alarm enable status and alarm activation. When the switch_enable signal is active, the module compares the current time with the set alarm time. If the current time matches the alarm time, the alarm is activated by setting the alarm_LED to 1. If the current time matches the alarm time incremented by 2 min, the alarm is deactivated by setting the alarm_LED to 0. The alarm_enable_LED indicates the status of the alarm enable, and when the switch_enable signal is not active, the alarm is disabled, and the alarm_enable_LED is set to 0.

5) hourlychime.v : This module is in accordance with chime of the hour that rings every hour equal to hour number of times. It is designed to glow an LED every time at the zeroth minute of every hour.

4) LT24Top.v : This module is a LCD IP core that is reused to show the time in HH:MM format and is synchronized with the real time on seven segment display. LT24Top.v act as the top module for the LCD integration. It reuses LT24Display.v to provide internal logic to maintain the various states of the LCD's ILI9341 controller.
