----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2024 05:22:36 PM
-- Design Name: 
-- Module Name: Master_Protocol - Structural
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

entity Master_Protocol is
--  Port ( );
end Master_Protocol;

architecture Structural of Master_Protocol is
component Write8bit is 
    port (
        clk: in std_logic;
        rst : in std_logic;
        word_data : in STD_LOGIC_VECTOR(7 downto 0);
        Start_write : in std_logic;
        done_write : out std_logic;
        ONE_WIRE_OUT : out std_logic
    );
end component;


begin


end Structural;
