----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2024 05:32:56 PM
-- Design Name: 
-- Module Name: Temp_mem - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Temp_Memory is

    Port ( 
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           mem_wr   : in STD_LOGIC;
           val      : in STD_LOGIC;
           Temp     : out STD_LOGIC_VECTOR (7 downto 0);
           d_read   : in std_logic
           );
end Temp_Memory;

architecture Behavioral of Temp_Memory is

    signal mem_val: std_logic_vector(7 downto 0);
    signal count_data : integer range 0 to 10;
    
    begin
    
        process(rst, clk)
        begin
             if rst='1' then
                count_data<=0;
                mem_val <= "00000000";
                Temp <= "00000000";
      
 elsif rising_edge(clk) then 
	     
	    if (mem_wr ='1') then
            count_data <= count_data + 1;
            mem_val(count_data) <=val;
            if count_data = 7 then 
                count_data<=0;
            end if;
         
         end if;
         
     end if;    
           Temp <= mem_val;      
        end process;
        
end Behavioral;
