
--write 0 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity Write_0bit is 
    port (
        clk: in std_logic;
        rst: in std_logic;
        en_writing : in std_logic;
        done_writing : out std_logic
    );
end Write_0bit;

architecture Behavioral of Write_0bit is

signal count: integer range 0 to 60000;
    begin
        process(rst, clk)
            begin
            if (rst ='1') then 
                done_writing <= '0';
                count<= 0; 
            elsif rising_edge(clk) then 
                if en_writing = '1' then
                    if count = 6000 then 
                        done_writing <= '1';
                        count <= 0; 
                       -- ONE_WIRE_OUT <='1';
                    else 
                        count <= count+1;
                        done_writing<='0';
                       -- ONE_WIRE_OUT <='0';
                end if;
            end if;
        end if;
        end process ;
end Behavioral;

