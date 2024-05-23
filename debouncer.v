
module debouncer(
    input clk,
    input button_in,

    output button_out
);

reg [7:0] mask;       // counter register
reg button = 0;

always @(posedge clk) begin
    if (button_in == 0) begin
        mask <= 0;
        button <= 0;
    end
    else begin
        mask <= mask + 1;
        if (mask == 8'b11111111) begin
            button <= 1;
            mask <= 0;
        end
    end
end

assign button_out = button;
endmodule