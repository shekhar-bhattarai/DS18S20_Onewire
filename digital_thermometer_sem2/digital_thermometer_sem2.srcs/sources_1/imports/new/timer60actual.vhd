----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2024 16:27:03
-- Design Name: 
-- Module Name: timer60actual - Behavioral
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

entity Timer60 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer60_start : in STD_LOGIC;
           timer60_done : out STD_LOGIC);
end Timer60;

architecture Behavioral of Timer60 is

signal count: integer range 0 to 6000;

begin

process(clk,rst)
begin


  if rst='1' then
      count<=0;
      timer60_done<='0';
      
 elsif rising_edge(clk) then 
	     
	    if (timer60_start ='1') then
            count <= count + 1;
            timer60_done <='0';   --master drives the line to 0& count <48000
            if count =6000 then 
                timer60_done <='1';
                count<=0;
            end if;
         else
         timer60_done <='0';
         
         end if;
         
     end if;
         
         
               
             
      
      
end process;
end Behavioral;
