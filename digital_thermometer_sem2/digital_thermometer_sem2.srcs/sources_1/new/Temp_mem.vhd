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
           T_val      : in STD_LOGIC_vector (7 downto 0);
           Temp     : out STD_LOGIC_VECTOR (7 downto 0)
           );
end Temp_Memory;

architecture Behavioral of Temp_Memory is

    signal count : integer range 0 to 100000000;
    
    begin
    
        process(rst, clk)
        begin
             if rst='1' then
                count <=0;
                Temp <= "00000000";
      
 elsif rising_edge(clk) then 
           
            if count = 100000000 then 
                Temp <= T_val;
                count <= 0;
            else 
               count <= count + 1; 
            end if;
         
  end if;
            
                
        end process;
        
end Behavioral;
