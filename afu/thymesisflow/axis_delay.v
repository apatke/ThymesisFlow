
`timescale 1ns / 10ps

module axis_delay (

    input              clock                   // Clock - samples & launches data on rising edge
  , input              reset_n                //  Active Low

  // 64B incoming data Interface
  , input   [511:0]     saxis_tdata
  , input               saxis_tvalid
  , output              saxis_tready
  
  , output [511:0]      maxis_tdata
  , output              maxis_tvalid
  , input               maxis_tready

);

reg [15:0] counter;

reg [511:0] output_q;
reg         output_q_vld;

assign maxis_tdata = output_q;
assign maxis_tvalid = output_q_vld;

always @(posedge(clock))
begin
       if (reset_n == 1'b0)
    begin
      counter <= 8'b0;
    end
   else
    begin
      counter <= counter + 8'b1;
    end
end

assign saxis_tready = maxis_tready && (counter%100==0);

always @(posedge(clock))
begin
  if (reset_n == 1'b0)
    begin
      output_q     <= 512'b0;
      output_q_vld <=   1'b0;
    end
  else if ((saxis_tready == 1'b1) &&  (saxis_tvalid == 1'b1))
    begin
       output_q                          <= saxis_tdata; 
       output_q_vld                      <= 1'b1;
    end
  else if (maxis_tready == 1'b1)
       output_q_vld                      <= 1'b0;
end


endmodule