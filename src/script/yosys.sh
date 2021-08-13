read_verilog ./module/vsdbabysoc.v
read_verilog -I../post_synth_sim -I./include ../post_synth_sim/rvmyth.v
read_verilog -I./include ./module/clk_gate.v
read_liberty -lib ./lib/avsd_pll_1v8.lib
read_liberty -lib ./lib/avsddac.lib
read_liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
synth -top vsdbabysoc
dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib
opt
abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime;{D};strash;dch,-f;map,-M,1,{D}
flatten
setundef -zero
clean -purge
rename -enumerate
stat
write_verilog -noattr ../post_synth_sim/vsdbabysoc.synth.v
