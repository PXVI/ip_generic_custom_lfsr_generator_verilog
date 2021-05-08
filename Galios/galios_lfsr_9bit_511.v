/* -----------------------------------------------------------------------------------
 * Module Name  : galios_lfsr_9bit_511
 * Date Created : 20:51:06 IST, 19 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : 9 Bit Galios LFSR ( Tap List : [ 9, 5, 1 ] )
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

module galios_lfsr_9bit_511 #(    parameter RST_SEED_VAL = 1 ) ( input RSTn, input CLK, output [8:0] lfsr_out );

    reg [8:0] lfsr_data_p, lfsr_data_n;

    always@( lfsr_data_p, RSTn )
    begin
        lfsr_data_n[8] = lfsr_data_p[0];
        lfsr_data_n[7] = lfsr_data_p[7+1];
        lfsr_data_n[6] = lfsr_data_p[6+1];
        lfsr_data_n[5] = lfsr_data_p[5+1];
        lfsr_data_n[4] = lfsr_data_p[4+1] ^ lfsr_data_p[0];
        lfsr_data_n[3] = lfsr_data_p[3+1];
        lfsr_data_n[2] = lfsr_data_p[2+1];
        lfsr_data_n[1] = lfsr_data_p[1+1];
        lfsr_data_n[0] = lfsr_data_p[0+1];
    end

    always@( posedge CLK or negedge RSTn )
    begin
        lfsr_data_p <= lfsr_data_p;

        if( !RSTn )
        begin
            lfsr_data_p <= RST_SEED_VAL;
        end
        else
        begin
            lfsr_data_p <= lfsr_data_n;
        end
    end

    assign lfsr_out = lfsr_data_p;

endmodule
