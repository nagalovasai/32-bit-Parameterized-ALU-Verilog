####################################################
# ALU SDC File (Combinational ALU)
####################################################

# Input delays
set_input_delay 1 [all_inputs]

# Output delays
set_output_delay 1 [all_outputs]

# Design Constraints
set_max_fanout 20 [current_design]
set_max_transition 0.5 [current_design]
set_max_capacitance 0.5 [current_design]

# Maximum delay from inputs to outputs
set_max_delay 10 -from [all_inputs] -to [all_outputs]
