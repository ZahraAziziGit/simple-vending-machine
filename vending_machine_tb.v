`timescale 1s/1ms

`include "Azizi.Zahra.402243083.VendingMachine.v"

module vending_machine_tb();

    reg clk = 0;
    reg reset;
    reg [1:0] select;
    reg [1:0] coin;
    reg dispense;

    wire [8*30-1:0] LCD;
    wire [8*30-1:0] money;
    wire motor;

    vending_machine vm (
        .clk(clk),
        .reset(reset),
        .select(select),
        .coin(coin),
        .dispense(dispense),
        .LCD(LCD),
        .money(money),
        .motor(motor)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin

        $dumpfile("test_vm.vcd");
	$dumpvars(0, vending_machine_tb);
     
        dispense = 0;
        reset = 1;
        #10;
        $display("before tests\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        reset = 0;

        // Test 1: Select item 1 (price 10c) and insert 10c
        $display("Test 1------------------------------------------------------------------------------------------------------------");
        select = 2'b00;
        #10;
        $display("select p1\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        coin = 2'b00; 
        #10; 
        $display("insert 10c\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        #10;
        $display("dispense cont.\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        dispense = 1;
        #10
        $display("finished\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        // Test 2: Select item 2 (price 20c) and insert 20c
        $display("Test 2------------------------------------------------------------------------------------------------------------");
        select = 2'b01;
        #10;
        dispense = 0;
        $display("select p2\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        coin = 2'b01; 
        #10; 
        $display("insert 20c\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        dispense = 1;
        #10
        $display("finished\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        // Test 3: Select item 3 (price 30c) and insert 20c (insufficient)
        $display("Test 3------------------------------------------------------------------------------------------------------------");
        select = 2'b10;
        dispense = 0;
        #10;
        $display("select p3\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        coin = 2'b01; 
        #10; 
        $display("insert 20c\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        #10;
        $display("return money\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        #10;
        $display("finished\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        // Test 4: Select item 3 (price 30c) and insert 50c (return change)
        $display("Test 4------------------------------------------------------------------------------------------------------------");
        select = 2'b10;
        #10;
        $display("select p3\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        coin = 2'b10; 
        #10; 
        $display("insert 50c\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        dispense = 1;
        #10;
        $display("change returned\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        #10;
        $display("finished\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        // Test 5: Select item 4 (out of stock)
        $display("Test 5------------------------------------------------------------------------------------------------------------");
        select = 2'b11;
        dispense = 0;
        #10;
        $display("select p4\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        #10;
        $display("finished\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        //Test 6: Select item 3 then reset
        $display("Test 6------------------------------------------------------------------------------------------------------------");
        select = 2'b10;
        #10;
        $display("select p3.\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        reset = 1;
        #10;
        $display("after reset\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        reset = 0;

        // Test 7: Select item 2 until it is out of stock
        $display("Test 7------------------------------------------------------------------------------------------------------------");
        select = 2'b01;
        #10;
        dispense = 0;
        $display("select p2\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        coin = 2'b01; 
        #10; 
        $display("insert 20c\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);
        dispense = 1;
        #10
        $display("dispense fin.\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        select = 2'b01;
        #10;
        dispense = 0;
        $display("select p2\t Time: %0d | LCD: %s | money: %s | Motor: %b", 
                $time, LCD, money, motor);

        #100; 
        $display("Finish------------------------------------------------------------------------------------------------------------");
        $finish;
    end

endmodule
