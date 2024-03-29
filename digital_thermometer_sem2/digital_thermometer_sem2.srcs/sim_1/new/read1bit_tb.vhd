----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2024 05:34:01 PM
-- Design Name: 
-- Module Name: read1bit_tb - Behavioral
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

entity read1bit_tb is
--  Port ( );
end read1bit_tb;

architecture Behavioral of read1bit_tb is

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
     signal  sig_clk: std_logic;
     signal  sig_rst: std_logic;
     signal   sig_Read_wire : std_logic;
     signal   sig_start_reading :  std_logic;
     signal   sig_timer_15us_done : std_logic;
     signal  sig_timer_1us_done : std_logic;
     signal   sig_timer_60us_done :  std_logic;
     signal   sig_en_timer_1us: std_logic;
     signal   sig_en_timer_15us: std_logic;
     signal   sig_en_timer_60us: std_logic;
     signal   sig_write_bit :  std_logic;
     signal   sig_write_mem : std_logic ;
    
begin

tbread8bit: Read1bit 
port map (
      clk               => sig_clk, 
      rst               => sig_rst,
      Read_wire         => sig_Read_wire, 
      start_reading     => sig_start_reading,  
      timer_15us_done   => sig_timer_15us_done,
      timer_1us_done    => sig_timer_1us_done ,
      timer_60us_done   => sig_timer_60us_done, 
      en_timer_1us      => sig_en_timer_1us,
      en_timer_15us     => sig_en_timer_15us, 
      en_timer_60us     => sig_en_timer_60us,
      write_bit         => sig_write_bit,
      write_mem         => sig_write_mem
);
sig_clk<= not sig_clk after 5ns;
sig_start_reading <= '1';

process 

begin



end process;
end Behavioral;
