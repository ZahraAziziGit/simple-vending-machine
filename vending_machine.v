module vending_machine(
    output reg [8*30-1:0] LCD,
    output reg [8*30-1:0] money,
    output reg motor,
    input clk,
    input reset,
    input [1:0] select,
    input [1:0] coin,
    input dispense
);

    reg [3:0] current_state;
    reg [3:0] next_state;

    parameter idle = 4'b0000;
    parameter wait_10c = 4'b0001;
    parameter wait_20c = 4'b0010;
    parameter wait_30c = 4'b0011;
    parameter wait_40c = 4'b0100;
    parameter dispensing = 4'b0101;
    parameter return_money = 4'b0110;
    parameter insufficient = 4'b0111;
    parameter return_change = 4'b1000;
    parameter out_of_stock = 4'b1001;

    reg [7:0] product_price [3:0]; 
    reg [7:0] product_count [3:0]; 

    integer balance;
    integer change;

    initial begin
        product_price[0] = 10;
        product_price[1] = 20;
        product_price[2] = 30;
        product_price[3] = 40;

        product_count[0] = 4;
        product_count[1] = 2;
        product_count[2] = 2;
        product_count[3] = 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) current_state <= idle;

        else begin
            case (current_state)
                default: current_state <= idle;
                idle: begin
                    if (product_count[select] > 0)
                        current_state <= next_state;
                    else
                        current_state <= out_of_stock;    
                end
                wait_10c, wait_20c, wait_30c, wait_40c, return_money, out_of_stock,
                    insufficient, return_change: current_state <= next_state;
                dispensing: begin
                    if (dispense == 1) begin
                        product_count[select] = product_count[select] - 1;
                        current_state <= next_state;
                    end
                    else
                        current_state <= dispensing;
                end
            endcase
        end
    end

    always @(current_state) begin
        case (current_state)
                default: current_state <= idle;
                idle: begin
                    LCD <= "idle";
                    money <= "0c";
                    motor <= 0;
                end
                wait_10c: begin
                    LCD <= "waiting for 10c";
                    money <= "0c";
                    motor <= 0;
                end
                wait_20c: begin
                    LCD <= "waiting for 20c";
                    money <= "0c";
                    motor <= 0;
                end
                wait_30c: begin
                    LCD <= "waiting for 30c";
                    money <= "0c";
                    motor <= 0;
                end
                wait_40c: begin
                    LCD <= "waiting for 40c";
                    money <= "0c";
                    motor <= 0;
                end
                return_change: begin
                    LCD <= "returning change";
                    begin 
                    balance = (coin == 2'b00) ? 10 :
                              (coin == 2'b01) ? 20 :
                              (coin == 2'b10) ? 50 :
                              (coin == 2'b11) ? 100 : 0;
                    end
                    change = balance - product_price[select];
                    money <= {"change: ", (change == 10) ? "10c" :
                        (change == 20) ? "20c" :
                        (change == 30) ? "30c" :
                        (change == 40) ? "40c" :
                        (change == 60) ? "60c" :
                        (change == 70) ? "70c" :
                        (change == 80) ? "80c" :
                        (change == 90) ? "90c" : "0c"};
                        motor <= 0;
                end
                return_money: begin
                    LCD <= "returning money";
                    money <= {"return amount: ", (coin == 2'b00) ? "10c" :
                        (coin == 2'b01) ? "20c" :
                        (coin == 2'b10) ? "50c" :
                        (coin == 2'b11) ? "100c" : "0c"}; 
                    motor <= 0;
                end
                insufficient: begin
                    LCD <= "insufficient";
                    begin 
                    balance = (coin == 2'b00) ? 10 :
                              (coin == 2'b01) ? 20 :
                              (coin == 2'b10) ? 50 :
                              (coin == 2'b11) ? 100 : 0;
                    end
                    change = product_price[select] - balance;
                    money <= {"needs: ", (change == 10) ? "10c" :
                        (change == 20) ? "20c" :
                        (change == 30) ? "30c" : "0c"};
                    motor <= 0;
                end
                out_of_stock: begin
                    LCD <= "out of stock";
                    money <= "ERROR";
                    motor <= 0;
                end
                dispensing: begin
                    LCD <= "dispensing";
                    money <= {"inserted amount: ", (product_price[select] == 10) ? "10c" :
                        (product_price[select] == 20) ? "20c" :
                        (product_price[select] == 30) ? "30c" :
                        (product_price[select] == 40) ? "40c" : "0c"}; 
                    motor <= 1;
                end
            endcase    
    end


    always @(current_state or select or coin or dispense) begin
        case(current_state)
            default: next_state = idle;
            idle: begin 
                    next_state = (select == 2'b00) ? wait_10c :
                        (select == 2'b01) ? wait_20c :
                        (select == 2'b10) ? wait_30c :
                        (select == 2'b11) ? wait_40c : idle;
                    end
            wait_10c: case(coin)
                2'b00: next_state = dispensing;
                2'b01: next_state = return_change;       
                2'b10, 2'b11: next_state = return_change; 
            endcase  
            wait_20c: case(coin)
                2'b00: next_state = insufficient;
                2'b01: next_state = dispensing;       
                2'b10, 2'b11: next_state = return_change; 
            endcase  
            wait_30c, wait_40c: case(coin)
                2'b00: next_state = insufficient;     
                2'b01: next_state = insufficient; 
                2'b10, 2'b11: next_state = return_change; 
            endcase
            return_change: next_state = dispensing;
            dispensing: next_state = ((dispense == 1) ? idle : dispensing);
            insufficient: next_state = return_money;
            return_money: next_state = idle;
            out_of_stock: next_state = idle;
        endcase
    end

endmodule
