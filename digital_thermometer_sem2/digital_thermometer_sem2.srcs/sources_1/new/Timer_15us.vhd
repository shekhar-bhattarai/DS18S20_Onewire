----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2024 12:59:47
-- Design Name: 
-- Module Name: timer_1us - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity Timer_15us is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer15_start : in STD_LOGIC;
           timer15_done : out STD_LOGIC);
end Timer_15us;

architecture Behavioral of Timer_15us is

signal count: integer range 0 to 1500;

begin

process(clk,rst)
begin


  if rst='1' then
      count<=0;
      timer15_done<='0';
      
 elsif rising_edge(clk) then 
	     
	    if (timer15_start ='1') then
            count <= count + 1;
            timer15_done <='0';   --master drives the line to 0& count <48000
            if count =1500 then 
                timer15_done <='1';
                count<=0;
            end if;
         else
         timer15_done <='0';
         
         end if;
         
     end if;    
      
end process;

end Behavioral;

