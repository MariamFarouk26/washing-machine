module washing_states
( input  wire [1:0]    clk_freq,
  input  wire          coin,
  input  wire          double_wash,
  input  wire          rst,
  input  wire          clk,
  input  wire          pause,
  input  wire          minutes_1,
  input  wire          minutes_2,
  input  wire          minutes_5,
  output reg  [2:0]    current_state,
  output reg           wash_done
)

localparam [2:0] IDLE = 3'b000,
                 Filling_Water =3'b1,
                 Washing =3'b10,
                 Rinsing =3'b11,
                 Spinning =3'b100;


 reg    [2:0]      next_state ;
                     
  //state transition
  always @(posedge clk or negedge rst) 
  begin
    if(!rst)
     begin
        current_state <= IDLE;
     end
    else
     begin
         current_state <= next_state;
     end
  end



  //next_state
always @(*)
   begin
 case (current_State)
            IDEL :  begin
                   if(coin==1'b1)
                    begin
                     next_state = Filling_Water;
                    end
                   else
                    begin
                     next_state = IDEL;
                    end
                    end
    Filling_Water : begin
                   if(minutes_2)
                    begin
                     next_state = Washing;
                    end
                   else
                    begin
                     next_state = Filling_Water;
                    end
                    end   
        Washing   : begin
                   if(minutes_5)
                    begin
                     next_state = Rinsing;
                    end
                   else
                    begin
                     next_state = Washing;
                    end
                     end  
        Rinsing  :  begin
                   if(double_wash)
                     begin
                     next_state = Washing;
                     end
                   else if(minutes_2)
                    begin
                     next_state = Spinning;
                    end
                   else
                    begin
                     next_state = Rinsing;
                    end
                     end  
    Spinning :

       default: 
    endcase
   end

endmodule
