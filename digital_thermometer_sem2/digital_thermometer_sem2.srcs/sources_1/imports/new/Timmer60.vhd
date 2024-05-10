----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2024 15:52:05
-- Design Name: 
-- Module Name: Timmer60 - Behavioral
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

entity Timmer480 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer480_start : in STD_LOGIC;
           timer480_done : out STD_LOGIC);
end Timmer480;

architecture Behavioral of Timmer480 is

signal count: integer range 0 to 48000;

begin

process(clk,rst)
begin


  if rst='1' then
      count<=0;
      timer480_done<='0';
      
 elsif rising_edge(clk) then 
	     
	    if (timer480_start ='1') then
            count <= count + 1;
            timer480_done <='0';   --master drives the line to 0& count <48000
            if count = 48000 then 
                timer480_done <='1';
                count<=0;
            end if;
         else
         timer480_done <='0';
         
         end if;
         
     end if;
         
         
               
             
      
      
end process;
end Behavioral;
