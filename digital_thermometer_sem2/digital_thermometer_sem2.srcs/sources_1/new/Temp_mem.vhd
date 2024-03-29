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
           mem_wr     : in STD_LOGIC;
           val   : in STD_LOGIC;
           position : in STD_LOGIC_VECTOR (3 downto 0);
           Temp     : out STD_LOGIC_VECTOR (8 downto 0));
end Temp_Memory;

architecture Behavioral of Temp_Memory is

    signal mem_val: std_logic_vector(8 downto 0);
    
    begin
    
        process(rst, clk)
        begin
            if (rst = '1') then
                mem_val <= "000000000";
            elsif rising_edge(clk) then
                if mem_wr = '1' then
                    case position is
                        when x"0" => mem_val(0) <= val;
                        when x"1" => mem_val(1) <= val;
                        when x"2" => mem_val(2) <= val;
                        when x"3" => mem_val(3) <= val;
                        when x"4" => mem_val(4) <= val;
                        when x"5" => mem_val(5) <= val;
                        when x"6" => mem_val(6) <= val;
                        when x"7" => mem_val(7) <= val;
                        when x"8" => mem_val(8) <= val;
                        when others => mem_val <= mem_val;
                    end case;
                else
                    mem_val <= mem_val;
                end if;
            
            end if;        
        end process;
        
end Behavioral;
