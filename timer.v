module timer
( input  wire [1:0]    clk_freq,
  input  wire          rst,
  input  wire          clk,
  input  wire [2:0]    current_state,
  input  wire          timer_pause,
  output wire          pause,
  output wire          minutes_1,
  output wire          minutes_2,
  output wire          minutes_5
);

reg [31:0]   counter;
reg [31:0]   end_count;
reg [2:0]    minutes;

localparam [2:0] IDLE = 3'b000,
                 Filling_Water =3'b001,
                 Washing =3'b010,
                 Rinsing =3'b011,
                 Spinning =3'b100,

always @(*) 
begin
  case (current_state)
    IDLE :
            begin
             minutes=3'd0;
            end
    Filling_Water:
           begin
             minutes=3'd2;
           end
    Washing:
           begin
            minutes=3'd5;
           end
    Rinsing:
           begin
            minutes=3'd2;
           end
   Spinning:
           begin
            minutes=3'd1;
           end
    default:
           begin
            minutes=3'd0;
           end
  endcase
end

always@(*)
begin 
  case(clk_freq)
    2'b00:end_count=31'd1;
    //31'd60000000;
    2'b01:end_count=31'd2;
    //31'd120000000;
    2'b10:end_count=31'd4;
    //31'd240000000;
    2'b11:end_count=31'd8;
    //31'd480000000;
  endcase
 end
 
 always @(posedge clk or negedge rst)
 begin
   if(!rst)
   begin
    counter<=31'b0;
   end
   else
   begin
    counter<=counter+31'b1;
   end
 end

always@(posedge clk)
begin 
case(minutes && end_count==31'd1)
 3'd1: begin
        if(counter==31'd1)
        //31'd60000000
         counter<=31'b0;
       end
 3'd2: begin 
        if(counter==31'd2)
        //31'd120000000
         counter<=31'b0;
       end
 3'd5:begin
         if(counter==31'd5)
        //31'd300000000/60000000
         counter<=31'b0;
       end
 default:begin
         if(pause==1'b1)
          counter<=counter;
         else
          counter<=31'b0;
         end
 endcase 
 end


 always@(posedge clk)
begin 
case(minutes && end_count==31'd2)
 3'd1: begin
        if(counter==31'd2)
        //31'd60000000
         counter<=31'b0;
       end
 3'd2: begin 
        if(counter==31'd4)
        //31'd120000000
         counter<=31'b0;
       end
 3'd5:begin
         if(counter==31'd10)
        //31'd300000000/60000000
         counter<=31'b0;
       end
 default:begin
         if(pause==1'b1)
          counter<=counter;
         else
          counter<=31'b0;
         end
 endcase 
 end



always@(posedge clk)
begin 
case(minutes && end_count==31'd4)
 3'd1: begin
        if(counter==31'd4)
        //31'd60000000
         counter<=31'b0;
       end
 3'd2: begin 
        if(counter==31'd8)
        //31'd120000000
         counter<=31'b0;
       end
 3'd5:begin
         if(counter==31'd20)
        //31'd300000000/60000000
         counter<=31'b0;
       end
 default:begin
         if(pause==1'b1)
          counter<=counter;
         else
          counter<=31'b0;
         end
 endcase 
 end


always@(posedge clk)
begin 
case(minutes && end_count==31'd8)
 3'd1: begin
        if(counter==31'd8)
        //31'd60000000
         counter<=31'b0;
       end
 3'd2: begin 
        if(counter==31'd16)
        //31'd120000000
         counter<=31'b0;
       end
 3'd5:begin
         if(counter==31'd40)
        //31'd300000000/60000000
         counter<=31'b0;
       end
 default:begin
         if(pause==1'b1)
          counter<=counter;
         else
          counter<=31'b0;
         end
 endcase 
 end


 assign pause = (current_state==3'd4 && timer_pause==1'b1);
 
 assign minutes_1 =(counter==31'd1 || counter==31'd2 || counter==31'd4 || counter==31'd8);
 //31'd60000000
 assign minutes_2 =(counter==31'd2 || counter==31'd4 || counter==31'd8 || counter==31'd16); 
 //31'd120000000
 assign minutes_5 =(counter==31'd5 || counter==31'd10 ||counter==31'd20 || counter==31'd40); 
 //31'd300000000
 
endmodule