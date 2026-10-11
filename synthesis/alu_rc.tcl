###############################################################
# ALU Synthesis Script - RC v12.10
###############################################################

# Library
set_attribute lib_search_path "/home/buet/cadence/EDI/share/FoundationFlows/EXAMPLES/PROTO/LIBS/GPDK/LIBS/GPDK045/timing" /
set_attribute library typical.lib /

# RTL Path
set_attribute hdl_search_path "." /

# Read RTL
read_hdl -v2001 alu_decoder.v
read_hdl -v2001 alu_core.v
read_hdl -v2001 alu_top.v

# Elaborate
elaborate alu_top

# Select top design
cd /designs/alu_top

# Constraints (optional)
# read_sdc alu.sdc

# Synthesis
synthesize -to_mapped

# Reports
report area   > alu_area.rpt
report timing > alu_timing.rpt
report power  > alu_power.rpt

# Netlist
write_hdl -v2001 > alu_netlist.v
