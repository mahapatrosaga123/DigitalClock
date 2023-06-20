
# Requre quartus project
package require ::quartus::project

# Set pin locations for HEX0
set_location_assignment PIN_AE26 -to D_S2[6]
set_location_assignment PIN_AE27 -to D_S2[5]
set_location_assignment PIN_AE28 -to D_S2[4]
set_location_assignment PIN_AG27 -to D_S2[3]
set_location_assignment PIN_AF28 -to D_S2[2]
set_location_assignment PIN_AG28 -to D_S2[1]
set_location_assignment PIN_AH28 -to D_S2[0]

# Set pin locations for HEX1
set_location_assignment PIN_AJ29 -to D_S1[6]
set_location_assignment PIN_AH29 -to D_S1[5]
set_location_assignment PIN_AH30 -to D_S1[4]
set_location_assignment PIN_AG30 -to D_S1[3]
set_location_assignment PIN_AF29 -to D_S1[2]
set_location_assignment PIN_AF30 -to D_S1[1]
set_location_assignment PIN_AD27 -to D_S1[0]

# Set pin locations for HEX2
set_location_assignment PIN_AB23 -to D_M2[6]
set_location_assignment PIN_AE29 -to D_M2[5]
set_location_assignment PIN_AD29 -to D_M2[4]
set_location_assignment PIN_AC28 -to D_M2[3]
set_location_assignment PIN_AD30 -to D_M2[2]
set_location_assignment PIN_AC29 -to D_M2[1]
set_location_assignment PIN_AC30 -to D_M2[0]

# Set pin locations for HEX3
set_location_assignment PIN_AD26 -to D_M1[6]
set_location_assignment PIN_AC27 -to D_M1[5]
set_location_assignment PIN_AD25 -to D_M1[4]
set_location_assignment PIN_AC25 -to D_M1[3]
set_location_assignment PIN_AB28 -to D_M1[2]
set_location_assignment PIN_AB25 -to D_M1[1]
set_location_assignment PIN_AB22 -to D_M1[0]

# Set pin locations for HEX4
set_location_assignment PIN_AA24 -to D_H2[6]
set_location_assignment PIN_Y23 -to D_H2[5]
set_location_assignment PIN_Y24 -to D_H2[4]
set_location_assignment PIN_W22 -to D_H2[3]
set_location_assignment PIN_W24 -to D_H2[2]
set_location_assignment PIN_V23 -to D_H2[1]
set_location_assignment PIN_W25 -to D_H2[0]

# Set pin locations for HEX5
set_location_assignment PIN_V25 -to D_H1[6]
set_location_assignment PIN_AA28 -to D_H1[5]
set_location_assignment PIN_Y27 -to D_H1[4]
set_location_assignment PIN_AB27 -to D_H1[3]
set_location_assignment PIN_AB26 -to D_H1[2]
set_location_assignment PIN_AA26 -to D_H1[1]
set_location_assignment PIN_AA25 -to D_H1[0]



# Set pin location for Clock
set_location_assignment PIN_AA16 -to clk_50MHz

# Commit assignments
export_assignments
