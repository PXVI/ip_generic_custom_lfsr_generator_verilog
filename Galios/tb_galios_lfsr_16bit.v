/* -----------------------------------------------------------------------------------
 * Module Name  : -
 * Date Created : 20:00:38 IST, 19 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : 16 Bit Galios LFSR Testbench
 * -----------------------------------------------------------------------------------

   MIT License

   Copyright (c) 2020 k-sva

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the Software), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

 * ----------------------------------------------------------------------------------- */

`include "galios_lfsr_16bit.v"

module top_galios_lfsr_16bit;

    reg [15:0] in;
    reg clk, rst;
    wire [15:0] out;

    reg [127:0] count;
    reg [127:0] first_val = 1;

    galios_lfsr_16bit mod ( .RSTn( rst ), .CLK( clk ), .lfsr_out( out ) );
 
    initial
    begin
        count = 0;

        fork
            begin
                clk = 0;
                forever
                begin
                    #5 clk = ~clk;
                end
            end
            begin
                rst = 0;
                #98 rst = 1;
                first_val = out;
                forever
                begin
                    @( posedge clk );
                    #1;
                    if( out == first_val )
                    begin
                        $display( "\nINFO -- The first value was %0d. It repeated after %0d iterations.\n", first_val, count+1 );
                        $finish;
                    end
                    else
                    begin
                        count = count + 1;
                    end
                end
            end
            begin
                forever
                begin
                    @( posedge clk );
                    $display( $time, " ->  clk : %0d, rst : %0d, lfsr_out : %0d", clk, rst, out );
                end
            end
        join
    end

    initial
    begin
        $dumpfile( "default_dump.vcd" );
        $dumpvars( 0, top_galios_lfsr_16bit );
    end

endmodule
