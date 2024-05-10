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
        pulldown_out: out std_logic;
        en_timer_1us: out std_logic;
        en_timer_15us: out std_logic;
        en_timer_60us: out std_logic;
        read_val : out std_logic_vector(7 downto 0);
        done_reading : out std_logic      
    );
    end component;
    
    -- memory module here 
    component Temp_Memory is

    Port ( 
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           T_val      : in STD_LOGIC_VECTOR (7 downto 0);
           Temp     : out STD_LOGIC_VECTOR (7 downto 0)
           );
end component;
    
    signal sig_val: std_logic_vector(7 downto 0);
    signal sig_d_read: std_logic;
    
begin
done_reading <= sig_d_read;
read8_bitval : read1bit
    port map (
        clk             => clk,
        rst             => rst,
        Read_wire       => ONE_wire_read,
        start_reading   => start_reading,
        timer_15us_done => timer_15us_done,
        timer_1us_done  => timer_1us_done,
        timer_60us_done => timer_60us_done,
        en_timer_1us    => en_timer_1us,
        en_timer_15us   => en_timer_15us,
        en_timer_60us   => en_timer_60us,
        pulldown_out => ONE_wire_write,
        done_reading => sig_d_read,
        read_val => sig_val
        
        );
        
        
    MEM_data: Temp_Memory 
        port map (
            clk     =>  clk, 
            rst     =>    rst,
            T_val     => sig_val,
            Temp    => mem_value
        );
    

end Structural;
