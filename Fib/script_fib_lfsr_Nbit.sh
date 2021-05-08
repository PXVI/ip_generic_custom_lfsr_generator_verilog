# -----------------------------------------------------------------------------------
# Module Name  : script_fib_lfsr_Nbit
# Date Created : 13:25:33 IST, 19 September, 2020 [ Saturday ]
#
# Author       : pxvi
# Description  : This is a simple shell script which will generate a simple N bit 
#                Fibbonacci LFSR module with a M type polynomial provided as input
# -----------------------------------------------------------------------------------
#
# MIT License
#
# Copyright (c) 2020 k-sva
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the Software), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# ----------------------------------------------------------------------------------- */

echo "-----------------------------------------------------------------------"
echo "Fibonnaci LFSR Module Generattion Script v1.0                   "
echo "-----------------------------------------------------------------------"
echo -n "Enter the width of the LFSR Polynomial ( eg. 16,32,64 so on ) : "

read lfsr_width;
if [ $lfsr_width -le 1 ]
then
    echo ""
    echo "[E] The width of the LFSR cannot be less than 2. Re-run the script & try again."
else
    echo "Pleae enter the tap values one after the other. The inputs will be considered as complete as sson as the last tap which is always 1 in Fib LFSR is given as input."
    echo "To give a simple example of what a tap is, consider a 16 bit LFSR polynomial x^16 + x^14 + x^13 + x^11 + 1. Here, the taps as 16, 14, 13, 11 and 1 ( 16,14,13,11,1)"
    echo "Note : This script is not absolutely error proof. So, as an advice, DO NOT ENTER THE SAME TAP VALUES AGAIN!"
    echo ""

    echo -n "Enter the positive integer tap value ( tap must be less than or euqal to the width of LFSR ) : "
    read tap_val
    i=0;

    if [ $tap_val -le 1 ]
    then
        if [ $tap_val -eq 1 ]
        then
            echo ""
            echo "[E] First tap entered is 1 which is invalid. Re-run the script & try again."
        elif [ $tap_val -gt $lfsr_width ]
        then
            echo ""
            echo "[E] Tap cannot be greater than the LFSR Width. Re-run the script & try again."
        else
            echo ""
            echo "[E] Invalid tap provided. Re-run the script & try again."
        fi
    else
        lfsr_width_minus_one=`expr $lfsr_width - 1`

        while [ $tap_val -gt 1 -a $tap_val -le $lfsr_width ]
        do
            ARRAY[$i]=$tap_val;
            i=`expr $i + 1`;

            echo -n "Enter the positive integer tap value ( tap must be less than or euqal to the width of LFSR ) : "
            read tap_val
        done

        if [ $tap_val -eq 1 ]
        then
            ARRAY[$i]=$tap_val;

            # Generate the Verilog Module
            #for i in "${ARRAY[@]}"
            #do
            #    echo "Tap : $i"
            #done

            tap_list="[ "

            for i in "${ARRAY[@]}"
            do
                if [ $i -eq 1 ]
                then
                    tap_list="${tap_list}${i} ]"
                else
                    tap_list="${tap_list}${i}, "
                fi
            done

            echo ""
            echo -n "Enter the LFSR module suffix ( eg, fib01, nex2, 001 etc ) : "
            read fib_suf

            file_name="fib_lfsr_${lfsr_width}bit_${fib_suf}.v"
            mod_name="fib_lfsr_${lfsr_width}bit_${fib_suf}"

            if [ -f $file_name ]
            then
                echo ""
                echo "[E] File already exists. Remove or rename the file and try re running the script again."
            else
                timestamp=`date "+%H:%M:%S"`;
                TOUCHFULLDATE=`date "+%d %B, %Y [ %A ]"`;
                timezone=`date "+%Z"`
                year=`date "+%Y"`

                touch $file_name;

                echo "/* -----------------------------------------------------------------------------------" >> $file_name;
                echo " * Module Name  : ${mod_name}" >> $file_name;
                echo " * Date Created : ${timestamp} ${timezone}, ${TOUCHFULLDATE}" >> $file_name;
                echo " *" >> $file_name;
                echo " * Author       : pxvi" >> $file_name;
                echo " * Description  : ${lfsr_width} Bit Fibbonacci LFSR ( Tap List : ${tap_list} )" >> $file_name;
                echo " * -----------------------------------------------------------------------------------" >> $file_name;
                echo "" >> $file_name;
                echo "   MIT License" >> $file_name;
                echo "" >> $file_name;
                echo "   Copyright (c) ${year} k-sva" >> $file_name;
                echo "" >> $file_name;
                echo "   Permission is hereby granted, free of charge, to any person obtaining a copy" >> $file_name;
                echo "   of this software and associated documentation files (the "Software"), to deal" >> $file_name;
                echo "   in the Software without restriction, including without limitation the rights" >> $file_name;
                echo "   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" >> $file_name;
                echo "   copies of the Software, and to permit persons to whom the Software is" >> $file_name;
                echo "   furnished to do so, subject to the following conditions:" >> $file_name;
                echo "" >> $file_name;
                echo "   The above copyright notice and this permission notice shall be included in all" >> $file_name;
                echo "   copies or substantial portions of the Software." >> $file_name;
                echo "" >> $file_name;
                echo "   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" >> $file_name;
                echo "   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," >> $file_name;
                echo "   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" >> $file_name;
                echo "   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" >> $file_name;
                echo "   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," >> $file_name;
                echo "   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE" >> $file_name;
                echo "   SOFTWARE." >> $file_name;
                echo "" >> $file_name;
                echo " * ----------------------------------------------------------------------------------- */" >> $file_name;
                echo "" >> $file_name;

                
                echo "module ${mod_name} #(    parameter RST_VAL = 1 ) ( input RSTn, input CLK, output [${lfsr_width_minus_one}:0] lfsr_out );" >> $file_name
                echo "" >> $file_name
                echo "    reg [${lfsr_width_minus_one}:0] lfsr_data_p, lfsr_data_n;" >> $file_name
                echo "    reg new_shift_bit;" >> $file_name
                echo "" >> $file_name
                echo "    always@( lfsr_data_p, RSTn )" >> $file_name
                echo "    begin" >> $file_name
                
                first_str="new_shift_bit = "
                taps_str=""
                arr_len=`expr ${#ARRAY[@]} - 1`
                m=0

                for i in "${ARRAY[@]}"
                do
                    m=`expr $m + 1`
                    if [ $i -ne 1 ]
                    then
                        taps_str="${taps_str}lfsr_data_p[${i}-1]"
                        if [ $m -eq $arr_len ]
                        then
                            taps_str="${taps_str}"
                        else
                            taps_str="${taps_str} ^ "
                        fi
                    else
                        taps_str="${taps_str};"
                    fi
                done
                first_str="${first_str} ${taps_str}"


                echo "        ${first_str}" >> $file_name
                echo "        lfsr_data_n = { lfsr_data_p[${lfsr_width_minus_one}-1:0], new_shift_bit };" >> $file_name
                echo "    end" >> $file_name
                echo "" >> $file_name
                echo "    always@( posedge CLK or negedge RSTn )" >> $file_name
                echo "    begin" >> $file_name
                echo "        lfsr_data_p <= lfsr_data_p;" >> $file_name
                echo "" >> $file_name
                echo "        if( !RSTn )" >> $file_name
                echo "        begin" >> $file_name
                echo "            lfsr_data_p <= RST_VAL;" >> $file_name
                echo "        end" >> $file_name
                echo "        else" >> $file_name
                echo "        begin" >> $file_name
                echo "            lfsr_data_p <= lfsr_data_n;" >> $file_name
                echo "        end" >> $file_name
                echo "    end" >> $file_name
                echo "" >> $file_name
                echo "    assign lfsr_out = lfsr_data_p;" >> $file_name
                echo "" >> $file_name
                echo "endmodule" >> $file_name
            fi
            
            if [ -f ${file_name} ]
            then
                echo ""
                echo "[S] The LFSR module was generated successfully."

                echo ""
                echo -n "Do you want to generate a simple testbench for this module [Y/N] : "
                read ans

                if [ $ans = "Y" ]
                then
                    tb_name="tb_${mod_name}"
                    tb_file_name="${tb_name}.v"

                    if [ -f ${tb_file_name} ]
                    then
                        echo ""
                        echo "[E] The testbench file already exists. Please remove all the files created so far and re-run the script."
                    else
                        timestamp=`date "+%H:%M:%S"`;
                        TOUCHFULLDATE=`date "+%d %B, %Y [ %A ]"`;
                        timezone=`date "+%Z"`
                        year=`date "+%Y"`

                        touch ${tb_file_name};

                        echo "/* -----------------------------------------------------------------------------------" >> $tb_file_name;
                        echo " * Module Name  : ${tb_name}" >> $tb_file_name;
                        echo " * Date Created : ${timestamp} ${timezone}, ${TOUCHFULLDATE}" >> $tb_file_name;
                        echo " *" >> $tb_file_name;
                        echo " * Author       : pxvi" >> $tb_file_name;
                        echo " * Description  : Test bench for the ${lfsr_width} Bit Fibbonacci LFSR ( Tap List : ${tap_list} )" >> $tb_file_name;
                        echo " * -----------------------------------------------------------------------------------" >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo "   MIT License" >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo "   Copyright (c) ${year} k-sva" >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo "   Permission is hereby granted, free of charge, to any person obtaining a copy" >> $tb_file_name;
                        echo "   of this software and associated documentation files (the "Software"), to deal" >> $tb_file_name;
                        echo "   in the Software without restriction, including without limitation the rights" >> $tb_file_name;
                        echo "   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" >> $tb_file_name;
                        echo "   copies of the Software, and to permit persons to whom the Software is" >> $tb_file_name;
                        echo "   furnished to do so, subject to the following conditions:" >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo "   The above copyright notice and this permission notice shall be included in all" >> $tb_file_name;
                        echo "   copies or substantial portions of the Software." >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo "   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" >> $tb_file_name;
                        echo "   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," >> $tb_file_name;
                        echo "   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" >> $tb_file_name;
                        echo "   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" >> $tb_file_name;
                        echo "   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," >> $tb_file_name;
                        echo "   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE" >> $tb_file_name;
                        echo "   SOFTWARE." >> $tb_file_name;
                        echo "" >> $tb_file_name;
                        echo " * ----------------------------------------------------------------------------------- */" >> $tb_file_name;
                        echo "" >> $tb_file_name;

                        q='"'
                        d='$'
                        h='#'
                        b='`'

                        echo "${b}include ${q}${file_name}${q}" >> ${tb_file_name}
                        echo "" >> ${tb_file_name}
                        echo "module top_fib_lfsr_16bit;" >> ${tb_file_name}
                        echo "" >> ${tb_file_name}
                        echo "    reg [${lfsr_width_minus_one}:0] in;" >> ${tb_file_name}
                        echo "    reg clk, rst;" >> ${tb_file_name}
                        echo "    wire [${lfsr_width_minus_one}:0] out;" >> ${tb_file_name}
                        echo "" >> ${tb_file_name}
                        echo "    reg [127:0] count;" >> ${tb_file_name}
                        echo "    reg [127:0] first_val = 1;" >> ${tb_file_name}
                        echo "" >> ${tb_file_name}
                        echo "    ${mod_name} mod ( .RSTn( rst ), .CLK( clk ), .lfsr_out( out ) );" >> ${tb_file_name}
                        echo " " >> ${tb_file_name}
                        echo "    initial" >> ${tb_file_name}
                        echo "    begin" >> ${tb_file_name}
                        echo "        count = 0;" >> ${tb_file_name}
                        echo "" >> ${tb_file_name}
                        echo "        fork" >> ${tb_file_name}
                        echo "            begin" >> ${tb_file_name}
                        echo "                clk = 0;" >> ${tb_file_name}
                        echo "                forever" >> ${tb_file_name}
                        echo "                begin" >> ${tb_file_name}
                        echo "                    ${h}5 clk = ~clk;" >> ${tb_file_name}
                        echo "                end" >> ${tb_file_name}
                        echo "            end" >> ${tb_file_name}
                        echo "            begin" >> ${tb_file_name}
                        echo "                rst = 0;" >> ${tb_file_name}
                        echo "                ${h}98 rst = 1;" >> ${tb_file_name}
                        echo "                first_val = out;" >> ${tb_file_name}
                        echo "                forever" >> ${tb_file_name}
                        echo "                begin" >> ${tb_file_name}
                        echo "                    @( posedge clk );" >> ${tb_file_name}
                        echo "                    ${h}1;" >> ${tb_file_name}
                        echo "                    if( out == first_val )" >> ${tb_file_name}
                        echo "                    begin" >> ${tb_file_name}
                        echo "                        ${d}display( ${q}\nINFO -- The first value was %0d. It repeated after %0d iterations.\n${q}, first_val, count+1 );" >> ${tb_file_name}
                        echo "                        ${d}finish;" >> ${tb_file_name}
                        echo "                    end" >> ${tb_file_name}
                        echo "                    else" >> ${tb_file_name}
                        echo "                    begin" >> ${tb_file_name}
                        echo "                        count = count + 1;" >> ${tb_file_name}
                        echo "                    end" >> ${tb_file_name}
                        echo "                end" >> ${tb_file_name}
                        echo "            end" >> ${tb_file_name}
                        echo "            begin" >> ${tb_file_name}
                        echo "                forever" >> ${tb_file_name}
                        echo "                begin" >> ${tb_file_name}
                        echo "                    @( posedge clk );" >> ${tb_file_name}
                        echo "                    ${d}display( ${d}time, ${q} ->  clk : %0d, rst : %0d, lfsr_out : %0d${q}, clk, rst, out );" >> ${tb_file_name}
                        echo "                end" >> ${tb_file_name}
                        echo "            end" >> ${tb_file_name}
                        echo "        join" >> ${tb_file_name}
                        echo "    end" >> ${tb_file_name}
                        echo "endmodule" >> ${tb_file_name}


                        echo ""
                        echo "[S] Module and testbench, both have been created."
                    fi
                else
                    echo ""
                    echo "[S] Not interested? Okay, no problem."
                fi
            else
                echo ""
                echo "[E] Somethig went wrong. PLease delete any additional files created and re-run the script.."
            fi
        elif [ $tap_val -gt $lfsr_width ]
        then
            echo ""
            echo "[E] Tap cannot be greater than the LFSR Width. Re-run the script & try again."
        else
            echo ""
            echo "[E] Invalid tap provided. Re-run the script & try again."
        fi
    fi
fi
