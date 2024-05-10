----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2024 06:56:08 PM
-- Design Name: 
-- Module Name: Test_read_struct - structural
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

entity Test_read_struct is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        start_reading : in std_logic;
        ONE_wire_read : in std_logic;
        ONE_wire_write: out std_logic;
        mem_value : out std_logic_vector (7 downto 0) 
        );
end Test_read_struct;

architecture structural of Test_read_struct is
component Read_Struct is
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
        mem_value : out std_logic_vector (7 downto 0)
   );  
end component;

component Write8bit is 
    port (
        clk: in std_logic;
        rst : in std_logic;
        word_data : in STD_LOGIC_VECTOR(7 downto 0);
        Start_write : in std_logic;
        done_write : out std_logic;
        ONE_WIRE_OUT : out std_logic;
        en_time_1us   : out std_logic;
        en_time_60us   : out std_logic;
        done_timer_1us  : in std_logic;
        done_timer_60us : in std_logic
        
        
    );
end component;

component Timers is
  Port ( 
    clk               : in std_logic;
    rst               : in std_logic;
    start_timer_1us   : in std_logic;
    start_timer_60us  : in std_logic;
    done_timer_1us    : out std_logic;
    done_timer_60us   : out std_logic;
    start_timer_15us  : in std_logic;
    done_timer_15us   : out std_logic;
     start_timer_800ms  : in std_logic;
    done_timer_800ms    : out std_logic;
    start_timer_480us  : in std_logic;
    done_timer_480us    : out std_logic
    
  
  );
  
end component;
   signal sig_timer_15us_done :  std_logic;
   signal sig_timer_1us_done :  std_logic;
   signal sig_timer_60us_done :  std_logic;
   signal sig_timer_800ms_done :  std_logic;
    signal sig_timer_480us_done :  std_logic;
   signal sig_en_timer_1us:  std_logic;
   signal sig_en_timer_15us: std_logic;
   signal sig_en_timer_60us: std_logic;
    signal sig_en_timer_480us: std_logic;
   signal sig_en_timer_800ms: std_logic;
   signal sig_write_bit: std_logic;
begin
read8_bitval : Read_Struct
    port map (
        clk             => clk,
        rst             => rst,
        ONE_wire_read       => ONE_wire_read,
        start_reading   => start_reading,
        timer_15us_done => sig_timer_15us_done,
        timer_1us_done  => sig_timer_1us_done,
        timer_60us_done => sig_timer_60us_done,
        en_timer_1us    => sig_en_timer_1us,
        en_timer_15us   => sig_en_timer_15us,
        en_timer_60us   => sig_en_timer_60us,
        mem_value       => mem_value
        );
          
        
Timer_control: Timers
    port map (
        clk          => clk,   
    rst              => rst,
    start_timer_1us  => sig_en_timer_1us,
    start_timer_60us => sig_en_timer_60us,
    done_timer_1us   => sig_timer_1us_done,
    done_timer_60us  => sig_timer_60us_done,
    start_timer_15us => sig_en_timer_15us,
    done_timer_15us  => sig_timer_15us_done,
    start_timer_800ms => sig_en_timer_800ms,
    done_timer_800ms  => sig_timer_800ms_done,
    start_timer_480us => sig_en_timer_480us,
    done_timer_480us  => sig_timer_480us_done
    
    );
end structural;
----------------------------------------------------------------------------






  
 
    
  
    

