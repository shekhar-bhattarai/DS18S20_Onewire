----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 04:33:28 PM
-- Design Name: 
-- Module Name: sync_input - Behavioral
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

entity sync_input is
   Port (
         async_one_wire_in :in std_logic;
         clk : in std_logic;
         sync_one_wire_in:out std_logic;
         rst: in std_logic);
         
   
end sync_input;

architecture Behavioral of sync_input is

signal q1: std_logic;
signal q2: std_logic;


begin
process(rst,clk)
begin

        
if(rst='1') then
    q1<= '0';
    q2<= '0';
    elsif(rising_edge(clk))then
            q1 <= Async_one_wire_in;
            q2<= q1;
 end if;

  
end process;
     
sync_one_wire_in <= not(q2) and q1 ;
end Behavioral;
