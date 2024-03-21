library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Write8bit_tb is 
    --port is empty for the test bench 
end Write8bit_tb;

architecture Behavioral of Write8bit_tb is 

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
       signal sig_data_in : STD_LOGIC_VECTOR(7 downto 0 ):= "11001100"; --cch 

    signal clk :  STD_LOGIC:='0';
    signal rst :   STD_LOGIC:='0';
    signal sig_start : STD_LOGIC:='0';
    signal done : STD_LOGIC:='0';
   signal  ONE_WIRE_OUT :  std_logic;

        begin 

        testwrite8bfsm: Write8bit
            port map(
                clk=>clk,
                rst => rst,
                Start_write=> sig_start,
                done_write => done,
                word_data => sig_data_in,
                ONE_WIRE_OUT =>ONE_WIRE_OUT 
            );
        clk <= not clk after 5 ns;
            
            process 
                begin 
                
                    sig_start <='1';
                    wait for 10 us; 
                    sig_start <= '0';
                    wait ; 
            end process; 

end Behavioral;
