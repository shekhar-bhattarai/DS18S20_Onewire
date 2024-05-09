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
Port (                   clk    : in STD_LOGIC;
                           rst  : in STD_LOGIC;
                         start  : in STD_LOGIC;
              ONE_WIRE_IN_REAL  : in STD_LOGIC;  
                  ONE_WIRE_OUT  : out std_logic;
                    sens_detect : out std_logic;
                    write_done  : out std_logic;
                  mem_value     : out std_logic_vector (7 downto 0) 
            );
end Master_Protocol;

architecture Structural of Master_Protocol is

--------------------one wire signals-----------------------
signal sig_one_wire_in: std_logic;
signal sig_one_wire_out_init : std_logic;
signal sig_one_wire_out_read : std_logic;
signal sig_one_wire_out_write : std_logic;
-------------------------------------------------------------

signal sig_ONE_WIRE_OUT_final:std_logic;
signal sig_word_data:std_logic_vector(7 downto 0);
signal sig_mem_value:std_logic_vector(7 downto 0); --readcomponent
signal sig_Start_write:std_logic;
signal sig_Start_init:std_logic;
------------------------------------debuging-------------------------------------------
signal sig_finish_init:std_logic;
signal sig_finish_write:std_logic;
signal sig_finish_read:std_logic;

----------------------------------------------------------

signal sig_start_reading:std_logic;
signal sig_en_timer_1us:std_logic;
signal sig_en_timer_1us_write:std_logic;     --timer signals
signal sig_en_timer_1us_read:std_logic;
signal sig_en_timer_15us:std_logic;
signal sig_en_timer_60us:std_logic;
signal sig_en_timer_60us_write:std_logic;
signal sig_en_timer_60us_read:std_logic;
signal sig_en_timer_800ms:std_logic;
signal sig_timer_1us_done:std_logic;
signal sig_timer_60us_done:std_logic;
signal sig_timer_15us_done:std_logic;
signal sig_done_timer800ms:std_logic;


component Protocol_FSM is
    Port ( rst              : in STD_LOGIC;
           clk              : in STD_LOGIC;
           start            : in STD_LOGIC;
           finish_init      : in STD_LOGIC;
           finish_write     : in STD_LOGIC;
           finish_read      : in STD_LOGIC;
           start_init       : out STD_LOGIC;
           start_write      : out STD_LOGIC;
           start_read       : out std_logic;
           data             : out STD_LOGIC_VECTOR (7 downto 0);
           done_p           : out STD_LOGIC;
           en_timer_800ms   : out std_logic;
           done_timer_800ms : in std_logic
         );
end component;

component Initial is
    Port (  clk              : in STD_LOGIC;
           rst               : in STD_LOGIC;
           start             : in STD_LOGIC;
           ONE_WIRE_IN_REAL  : in STD_LOGIC;  
           ONE_WIRE_OUT_REAL : out STD_LOGIC;
           sens_detect       : out std_logic;
           done_init         : out std_logic
             );
end component;

component Write8bit is 
    port (
        clk             : in std_logic;
        rst             : in std_logic;
        word_data       : in STD_LOGIC_VECTOR(7 downto 0);
        Start_write     : in std_logic;
        done_write      : out std_logic;
        ONE_WIRE_OUT    : out std_logic;
        en_time_1us     : out std_logic;
        en_time_60us    : out std_logic;
        done_time_1us  : in std_logic;
        done_time_60us : in std_logic
        
        
    );
end component;

--component read
component Read_Struct is
  Port (
         clk: in std_logic;
        rst: in std_logic;
        ONE_wire_read : in std_logic;
        ONE_wire_write : out std_logic;
        start_reading : in std_logic;
        timer_15us_done : in std_logic;
        timer_1us_done : in std_logic;
        timer_60us_done : in std_logic;
        en_timer_1us: out std_logic;
        en_timer_15us: out std_logic;
        en_timer_60us: out std_logic;
        mem_value : out std_logic_vector (7 downto 0);
        done_reading : out std_logic
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
    done_timer_800ms    : out std_logic
    
  );
  
end component;

component TriState_buffer is
  Port (
      ONE_WIRE_IN : in std_logic;
      ONE_WIRE_OUT : out std_logic
 );
 end component;

begin
sig_en_timer_1us <= sig_en_timer_1us_write or sig_en_timer_1us_read;
sig_en_timer_60us <= sig_en_timer_60us_write or sig_en_timer_60us_read;
write_done <= sig_finish_write;
sens_detect <= sig_finish_init;
---------------------------for one wire in and out -------------------------------
sig_one_wire_in <= ONE_WIRE_IN_REAL;
sig_ONE_WIRE_OUT_final <= sig_one_wire_out_init and sig_one_wire_out_write and sig_one_wire_out_read;
----------------------------------------------------------------------------------

protocolfsm: Protocol_FSM
    port map (
        rst=> rst,
        clk => clk,
        start=> start,
        start_init => sig_Start_init,
        start_write => sig_Start_write,
        start_read => sig_start_reading,
        finish_init=> sig_finish_init,   
        finish_write=> sig_finish_write,
        finish_read  => sig_finish_read,
        en_timer_800ms => sig_en_timer_800ms,
        done_timer_800ms => sig_done_timer800ms,
        data=> sig_word_data
        
        
    );

initmap: Initial
  port map( rst               => rst,
            clk               => clk,
            start             => sig_Start_init,
            ONE_WIRE_IN_REAL  => sig_ONE_WIRE_IN,
            ONE_WIRE_OUT_REAL => sig_one_wire_out_init,
            sens_detect       => sig_finish_init,
            done_init         => sens_detect
            );
            
Write8bmap: Write8bit
  port map( rst             => rst,
            clk             => clk,
            Start_write     => sig_Start_write, ---connect to fsm
            word_data       => sig_word_data,
            done_write      => sig_finish_write,       ---connect to fsm
            ONE_WIRE_OUT    => sig_one_wire_out_write,
            en_time_1us     => sig_en_timer_1us_write,
            en_time_60us    => sig_en_timer_60us_write, 
            done_time_1us  => sig_timer_1us_done,
            done_time_60us => sig_timer_60us_done
               
            );
            
--read component portmap
read8_bitval : Read_Struct
    port map (
        clk             => clk,
        rst             => rst,
        ONE_wire_read   => sig_one_wire_in,
        ONE_wire_write  => sig_one_wire_out_read,
        start_reading   => sig_start_reading,   ---connect to fsm
        timer_15us_done => sig_timer_15us_done,
        timer_1us_done  => sig_timer_1us_done,
        timer_60us_done => sig_timer_60us_done,
        en_timer_1us    => sig_en_timer_1us_read,
        en_timer_15us   => sig_en_timer_15us,
        en_timer_60us   => sig_en_timer_60us_read,
        mem_value       => mem_value,
        done_reading    =>sig_finish_read     ---connect to fsm
        );
        
Timer_control: Timers
    port map (
                clk  =>  clk,   
                rst  =>  rst,
    start_timer_1us  => sig_en_timer_1us,
    start_timer_60us => sig_en_timer_60us,
    done_timer_1us   => sig_timer_1us_done,
    done_timer_60us  => sig_timer_60us_done,
    start_timer_15us => sig_en_timer_15us,
    done_timer_15us  => sig_timer_15us_done,
    start_timer_800ms => sig_en_timer_800ms,
    done_timer_800ms => sig_done_timer800ms
    
    );
    tristate_buff: TriState_buffer 
    port map (
   ONE_WIRE_IN => sig_ONE_WIRE_OUT_final,
   ONE_WIRE_OUT => ONE_WIRE_OUT
   );
   
    
    
end structural;              
