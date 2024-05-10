----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2024 08:29:35
-- Design Name: 
-- Module Name: Initial - Structural
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

entity Initial is
  Port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           ONE_WIRE_IN_REAL : in STD_LOGIC;  
           ONE_WIRE_OUT_REAL : out STD_LOGIC;
           sens_detect: out std_logic ;
           done_init : out std_logic
            
       
   );
end Initial;

architecture Structural of Initial is

-- signals for the interconnection of modules
         signal sig_time_out480 : STD_LOGIC;
         signal sig_time_out60 :  STD_LOGIC;
         signal  sig_en_timer480 : STD_LOGIC;
         signal sig_en_timer60 :  STD_LOGIC;
         signal OneW_out : std_logic;
         
component Initialization is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           time_out480 : in STD_LOGIC;
           time_out60 : in STD_LOGIC;
           ONE_WIRE_IN : in STD_LOGIC;
           ONE_WIRE_OUT : out STD_LOGIC;
           en_timer480: out STD_LOGIC;
           en_timer60: out STD_LOGIC;
           sens_detect: out std_logic;
           done_init : out std_logic  -- finish initialization 
            
             );
end component;

component Timmer480 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer480_start : in STD_LOGIC;
           timer480_done : out STD_LOGIC);
end component;

component Timer60 is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer60_start : in STD_LOGIC;
           timer60_done : out STD_LOGIC);
           
end component;

component TriState_buffer is
  Port (
      ONE_WIRE_IN : in std_logic;
      ONE_WIRE_OUT : out std_logic
 );
 end component;


begin


Timmer60: Timer60
  port map( rst=>rst,
            clk=>clk,
            timer60_start=>sig_en_timer60,
            timer60_done=>sig_time_out60);
            
Timer480:Timmer480
port map (rst=>rst,
        clk=>clk,
        timer480_start=>sig_en_timer480,
        timer480_done=>sig_time_out480); 
        
init:Initialization
port map ( clk=> clk,
           rst => rst,
           start=>start,
           time_out60=>sig_time_out60,
           time_out480=>sig_time_out480,
           ONE_WIRE_OUT=>ONE_WIRE_OUT_REAL,
           ONE_WIRE_IN=>ONE_WIRE_IN_REAL, 
           en_timer60=>sig_en_timer60,
           en_timer480=>sig_en_timer480,
           sens_detect=>sens_detect,
           done_init => done_init
           
           );              
--tristate: TriState_buffer 
--    port map (
--   ONE_WIRE_IN => OneW_out,
--   ONE_WIRE_OUT => ONE_WIRE_OUT_REAL
--   );
   
end Structural;
