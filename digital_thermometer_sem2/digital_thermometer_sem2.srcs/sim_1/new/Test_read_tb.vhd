----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2024 07:30:47 PM
-- Design Name: 
-- Module Name: Test_read_tb - Behavioral
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

entity Test_read_tb is
--  Port ( );
end Test_read_tb;

architecture Behavioral of Test_read_tb is

component Test_read_struct is
  Port (
        clk: in std_logic;
        rst: in std_logic;
        ONE_wire_read : in std_logic;
        start_reading : in std_logic;
        mem_value : out std_logic_vector (7 downto 0) 
        );
end component;

        signal clk:  std_logic:='0';
       signal  rst:  std_logic:='0';
        signal ONE_wire_read :  std_logic:='1';
        signal start_reading :  std_logic:='0';
        signal mem_value : std_logic_vector ( 7 downto 0) :="00000000";
        begin 

        testwrite8bfsm: Test_read_struct
            port map(
                clk=>clk,
                rst => rst,
                ONE_wire_read=> ONE_wire_read,
                start_reading => start_reading,
                mem_value => mem_value
                 
            );
            
        clk <= not clk after 5 ns;
            
            process 
                begin 
                    rst <='1';
                    wait for 10 us;
                    start_reading <='1';
                    rst <='0';
                    wait for 10 us; 
                    start_reading <='0';
                    ONE_wire_read <= '0';
                    wait for 10 us;
                    ONE_wire_read <= '1';
                    wait for 60 us ;
                    ONE_wire_read <= '0';
                    wait for 60 us;
                    ONE_wire_read <= '1';
                    wait ; 
            end process; 


end Behavioral;
