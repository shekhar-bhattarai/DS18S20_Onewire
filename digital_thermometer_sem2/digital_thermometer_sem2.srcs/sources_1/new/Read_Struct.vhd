----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2024 05:15:10 PM
-- Design Name: 
-- Module Name: Read_Struct - Structural
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

entity Read_Struct is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        ONE_wire_read : in std_logic;
        start_reading : in std_logic;
        timer_15us_done : in std_logic;
        timer_1us_done : in std_logic;
        timer_60us_done : in std_logic;
        en_timer_1us: out std_logic;
        en_timer_15us: out std_logic;
        en_timer_60us: out std_logic;
        write_bit : out std_logic;
        write_mem : out std_logic
  
   );
end Read_Struct;

architecture Structural of Read_Struct is
component Read1bit is 
    port (
        clk: in std_logic;
        rst: in std_logic;
        Read_wire : in std_logic;
        start_reading : in std_logic;
        timer_15us_done : in std_logic;
        timer_1us_done : in std_logic;
        timer_60us_done : in std_logic;
        en_timer_1us: out std_logic;
        en_timer_15us: out std_logic;
        en_timer_60us: out std_logic;
        write_bit : out std_logic;
        write_mem : out std_logic       
    );
    end component;
    
    -- memory module here 
    
begin


end Structural;
