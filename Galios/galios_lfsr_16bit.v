/* -----------------------------------------------------------------------------------
 * Module Name  : galios_lfsr_16bit
 * Date Created : 19:49:09 IST, 19 September, 2020 [ Saturday ]
 *
 * Author       : pxvi
 * Description  : Galios Linear Feedback Shift Register of 16bit width and
 *                the polynomial x^16 + x^14 + x^13 + x^11 + 1
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

module galios_lfsr_16bit #(    parameter RST_SEED_VAL = 1 ) (   
                                                        input RSTn,
                                                        input CLK,
                                                        output [15:0] lfsr_out
                                                    );

    reg [15:0] lfsr_data_p, lfsr_data_n;

    always@( lfsr_data_p, RSTn )
    begin

        lfsr_data_n[15] = lfsr_data_p[0];
        lfsr_data_n[14] = lfsr_data_p[15];
        lfsr_data_n[13] = lfsr_data_p[14] ^ lfsr_data_p[0];
        lfsr_data_n[12] = lfsr_data_p[13] ^ lfsr_data_p[0];
        lfsr_data_n[11] = lfsr_data_p[12];
        lfsr_data_n[10] = lfsr_data_p[11] ^ lfsr_data_p[0];
        lfsr_data_n[9] = lfsr_data_p[10];
        lfsr_data_n[8] = lfsr_data_p[9];
        lfsr_data_n[7] = lfsr_data_p[8];
        lfsr_data_n[6] = lfsr_data_p[7];
        lfsr_data_n[5] = lfsr_data_p[6];
        lfsr_data_n[4] = lfsr_data_p[5];
        lfsr_data_n[3] = lfsr_data_p[4];
        lfsr_data_n[2] = lfsr_data_p[3];
        lfsr_data_n[1] = lfsr_data_p[2];
        lfsr_data_n[0] = lfsr_data_p[1];
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
