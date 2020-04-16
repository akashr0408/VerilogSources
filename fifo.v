// FIFO design v0.1
// Original data : 04/15/2020

module fifo
#(
   parameter WIDTH = 32,
   parameter DEPTH = 32,
   parameter ADDR_WIDTH = 5
   )(
      aresetn,
      clock,
      read_or_write,
      data_in,
      empty,
      full,
      data_out
   );

   input                      aresetn;
   input                      clock;
   input                      read_or_write;
   input    [WIDTH-1:0]       data_in;
   output                     empty;
   output                     full;
   output   [WIDTH-1:0]       data_out;

   reg      [ADDR_WIDTH-1:0]  write_ptr;
   reg      [WIDTH-1:0]       fifo_reg_file  [DEPTH-1:0];

   always @ (posedge clock, negedge aresetn)
   begin
      if (!aresetn) begin
         empty <= 1;
         full <= 0;
         data_out <= 32'h0;
         write_ptr <= 5'h00;
      end
      else
      begin
         if (read_or_write)
         begin
            if (write_ptr == 5'h15)
            begin
               full <= 1;
            end
            if (!full)
            begin
               fifo_reg_file[write_ptr] <= data_in;
               write_ptr <= write_ptr + 1;
            end
         end
         else
         begin
            data_out <= fifo_reg_file[0];
            fifo_reg_file[0:ADDR_WIDTH-2] <= fifo_reg_file[1:ADDR_WIDTH-1];
            full <= 0;
            if (!full)
            begin
               write_ptr <= write_ptr - 1;
            end
         end
      end
   end
   endmodule 
