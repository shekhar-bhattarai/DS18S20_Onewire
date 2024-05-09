----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2024 03:34:06 PM
-- Design Name: 
-- Module Name: timer800ms - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
----------------------------------------------------------------------------------

entity Timer_800ms is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer800_start : in STD_LOGIC;
           timer800_done : out STD_LOGIC);
end Timer_800ms;

architecture Behavioral of Timer_800ms is

signal count: integer range 0 to 80000;

begin

process(clk,rst)
begin


  if rst='1' then
      count<=0;
      timer800_done<='0';
      
 elsif rising_edge(clk) then 
	     
	    if (timer800_start ='1') then
            count <= count + 1;
            timer800_done <='0';   --master drives the line to 0& count <48000
            if count = 80000 then 
                timer800_done <='1';
                count<=0;
            end if;
         else
         timer800_done <='0';
         
         end if;
         
     end if;    
      
end process;

end Behavioral;



