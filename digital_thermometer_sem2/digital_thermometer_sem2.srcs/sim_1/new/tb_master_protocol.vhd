----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2024 03:47:47 PM
-- Design Name: 
-- Module Name: tb_master_protocol - Behavioral
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

entity tb_master_protocol is
--  Port ( );
end tb_master_protocol;

architecture Behavioral of tb_master_protocol is


component Master_Protocol is
Port (                   clk    : in STD_LOGIC;
                           rst  : in STD_LOGIC;
                         start  : in STD_LOGIC;
              ONE_WIRE_IN_REAL  : in STD_LOGIC;  
                  ONE_WIRE_OUT  : out std_logic;
                    sens_detect : out std_logic;
                  mem_value     : out std_logic_vector (7 downto 0) 
            );
end component;
signal sig_mem_value : STD_LOGIC_VECTOR(7 downto 0):="00000000";
        signal clk :  STD_LOGIC:='0';
        signal rst :   STD_LOGIC:='0';
        signal sig_start : STD_LOGIC:='0';
        signal sig_ONE_WIRE_IN_REAL : STD_LOGIC:='1';
        signal sig_ONE_WIRE_OUT :  std_logic:='1';
        signal sig_sens_detect :  std_logic:='0'; 
        begin 
        
         initia: Master_Protocol
            port map(
                clk=>clk,
                rst=>rst,
                start=> sig_start,
                ONE_WIRE_IN_REAL => sig_ONE_WIRE_IN_REAL, 
                ONE_WIRE_OUT =>sig_ONE_WIRE_OUT, 
                sens_detect =>sig_sens_detect,
                mem_value=>sig_mem_value
            );
            
 clk <= not clk after 5 ns;
            
process 
   begin   
          rst <='1';
          wait for 5 us;
          rst<='0';
          sig_start <='1';
          wait for 10 us; 
          sig_start <= '0';
          sig_ONE_WIRE_IN_REAL<='0';
          wait for 4 ms ;
          sig_ONE_WIRE_IN_REAL<='0';
          wait for 60 us;
          sig_ONE_WIRE_IN_REAL<='1';
          wait for 120 us;
          sig_ONE_WIRE_IN_REAL<='0';
          wait for 100 us;
          sig_ONE_WIRE_IN_REAL<='1';
            wait;
                         
   
end process;        
end Behavioral;


