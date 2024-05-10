----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2024 12:39:53 AM
-- Design Name: 
-- Module Name: Timers - Structural
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

entity Timers is
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
  
end Timers;

architecture Structural of Timers is

component Timer_1us is
    
    Port (
        rst             : in STD_LOGIC;
        clk             : in STD_LOGIC;
        timer1_start    : in STD_LOGIC;
        timer1_done     : out STD_LOGIC
        );
 end component;

component Timer_60us is
    Port ( 
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        timer60_start : in STD_LOGIC;
        timer60_done : out STD_LOGIC
        );
        
end component;

component Timer_15us is
    Port (
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        timer15_start : in STD_LOGIC;
        timer15_done : out STD_LOGIC
        );
end component;
component Timer_480us is
    
    Port (
        rst             : in STD_LOGIC;
        clk             : in STD_LOGIC;
        timer480_start    : in STD_LOGIC;
        timer480_done     : out STD_LOGIC
        );
 end component;


component Timer_800ms is
    
    Port (
        rst             : in STD_LOGIC;
        clk             : in STD_LOGIC;
        timer800_start    : in STD_LOGIC;
        timer800_done     : out STD_LOGIC
        );
 end component;


begin
oneus_timer: Timer_1us 
    port map (
    clk          => clk,
    rst          => rst,
    timer1_start => start_timer_1us,
    timer1_done  => done_timer_1us
    
    );
    
fifteenus_timer: Timer_15us 
    port map (
    clk           => clk,
    rst           => rst,
    timer15_start => start_timer_15us,
    timer15_done  => done_timer_15us
    
    );
sixtyus_timer: Timer_60us 
    port map (
    clk           => clk,
    rst           => rst,
    timer60_start => start_timer_60us,
    timer60_done  => done_timer_60us
    
    );
fourEighty_ms_timer: Timer_480us 
    port map (
    clk           => clk,
    rst           => rst,
    timer480_start => start_timer_480us,
    timer480_done  => done_timer_480us
    
    );
    eighthundred_ms_timer: Timer_800ms 
    port map (
    clk           => clk,
    rst           => rst,
    timer800_start => start_timer_800ms,
    timer800_done  => done_timer_800ms
    
    );
end Structural;
