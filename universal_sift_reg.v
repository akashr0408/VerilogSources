module universal_shift_reg(parallel_out, serial_out, parallel_in, select, sr_in, sl_in, clock);

parameter N = 4;

output reg[N-1:0]    parallel_out;
output               serial_out;
input     [N-1:0]    parallel_in;
input     [1:0]      select;
input                sr_in, sl_in, clock;

reg       [N-1:0]    shift_reg;
reg                  ser_out;
initial shift_reg = 0; 

always @(posedge clock)
  begin
     case(select)
        2'b00:
           //do nothing
           ;
        2'b01:
           //shift left
           begin
              ser_out = shift_reg[N-1];
              shift_reg[N-1:0] <= {shift_reg[N-2:0], sl_in};
           end
        2'b10:
           //shift right
           begin
              ser_out <= shift_reg[0];
              shift_reg[N-1:0] <= {sr_in, shift_reg[N-1:1]};
           end
        2'b11:
           //parallel register like behavior
           parallel_out <= parallel_in;
     endcase
  end
assign serial_out = ser_out;
endmodule
