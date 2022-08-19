# washing-machine
the aim is to Desige washing controller unit which has five states each of them happen in specific period , the machine has 2 Option while working: 
	First Option of washing: that the machine filling water, washing, rinsing the spinning
	Second Option of washing: is the double wash option which include first option pulse a second wash and rinse to occur after completing the first rinse



>>>>the file describtion of the project:
Please consider the following design example for a controller unit for a washing machine
• The operation of the machine consists of the following states:
o Idle
o Filling Water
o Washing
o Rinsing
o Spinning

• The inputs/ outputs of the design are given by the below table Port Direction Description rst_n Input Active low asynchronous clock
clk          :  Input System clock 
clk_freq[1:0]:  Input Clock Frequency Configuration Code
coin_in      :  Input flag which is asserted when a coin is deposited 
double_wash  :  Input flag which is asserted if the user requires double wash option
timer_pause  :  Input flag when it is set to ‘1’ spinning phase is paused until this flag is de-asserted 
wash_done    :  output Active high output asserted when spinning phase is done and deasserted when coin_in is set to ‘1’

• The input clock can have 1 of 4 frequencies, encoded by the clk_freq[1:0] input port, the encoding is given by the following table
clk_freq      Clock Frequency (MHz)
2’b00               1
2’b01               2 
2’b10               4
2’b11               8


• The machine starts when a coin is deposited. (Assume that the user will only deposit the exact amount of coins)
• There is a double wash input, when it is turned on, a second wash and rinse to occur after completing the first rinse. Assume that the double wash button is pressed before depositing the coins (if needed) and stays pressed till the job completes.

• If the timer_pause flag is asserted during the spin cycle, the machine stops spinning until the flag is de-asserted. Note that the machine is designed to stop when this flag is raised only during the spin cycle.

• Each state of this machine takes a time period as stated in the following table :
State           Time Duration (Minutes)
Filling Water        2
Washing              5 
Rinsing              2
Spinning             1
