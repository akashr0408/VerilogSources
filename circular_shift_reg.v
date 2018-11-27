module circular_shift_reg(serial_out, reset, direction, data, clock);

parameter N = 8;
output serial_out;
input reset, clock, direction, data;

reg [N-1:0] shift_reg;
reg ser_out;

initial shift_reg = 8'bX;

always @(posedge clock)
begin
    if (^shift_reg === 1'bX || reset)
    begin
        case (direction)
        1'b0:
        begin
            shift_reg[N-1:0] <= {shift_reg[N-2:0], data};
            ser_out <= shift_reg[N-1];
        end
        1'b1:
        begin
            shift_reg[N-1:0] <= {data, shift_reg[N-1:1]};
            ser_out <= shift_reg[0];
        end
        endcase
    end
    else
    begin
        case (direction)
        1'b0:
        begin
            shift_reg[N-1:0] <= {shift_reg[N-2:0], shift_reg[N-1]};
            ser_out = shift_reg[N-1];
        end
        1'b1:
        begin
            shift_reg[N-1:0] <= {shift_reg[0], shift_reg[N-1:1]};
            ser_out <= shift_reg[0];
        end
        endcase
    end
end
assign serial_out = ser_out;
endmodule
