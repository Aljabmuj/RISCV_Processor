#Makefile for verilog files using iverilog and gtkwave

IVERILOG = iverilog
VVP = vvp 
GTKWAVE = gtkwave 

TARGET = sim.vpp
VCD = alu.vcd 

TOP = alu_tb
SRCS = $(wildcard *.v)

.PHONY: all sim wave clean 

all: sim 

#Note: $@ and $^ are used to shorthand the target and its dependencies

$(TARGET): $(SRCS)
	$(IVERILOG) -g2012 -s $(TOP) -o $@ $^ 

sim: $(TARGET)
	$(VVP) $(TARGET)

wave: $(VCD)
	$(GTKWAVE) $(VCD) & 

clean: 
	rm -f $(TARGET) $(VCD)
