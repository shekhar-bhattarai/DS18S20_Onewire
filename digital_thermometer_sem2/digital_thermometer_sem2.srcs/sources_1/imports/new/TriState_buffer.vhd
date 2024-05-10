----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.03.2024 11:17:31
-- Design Name: 
-- Module Name: TriState_buffer - Behavioral
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

entity TriState_buffer is
  Port (
      ONE_WIRE_IN : in std_logic;
      ONE_WIRE_OUT : out std_logic
 );
end TriState_buffer;

architecture Behavioral of TriState_buffer is

begin
 ONE_WIRE_OUT <= ONE_WIRE_IN when ONE_WIRE_IN <='0' else 'Z';
end Behavioral;
