library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Write8bit is 
    port (
        clk: in std_logic;
        rst : in std_logic;
        word_data : in STD_LOGIC_VECTOR(7 downto 0);
        Start_write : in std_logic;
        done_write : out std_logic;
        ONE_WIRE_OUT : out std_logic
    );
end Write8bit;

architecture Structural of Write8bit is 
    --components 3 components ie writebitfsm, write 0 write1, 
  component Writebit is
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            start : in STD_LOGIC;
            data_in : in STD_LOGIC_VECTOR(7 downto 0);
            done : out STD_LOGIC;
            write0 : out STD_LOGIC;
            write1 : out STD_LOGIC;
            done_writing1: in std_logic;
            done_writing0 : in std_logic;
            oneus_flag: in std_logic;
            start1us_timer : out std_logic;
             ONE_WIRE_OUT_W : out std_logic
        );
end component;

    component Write_1bit is 
        port (
            clk: in std_logic;
            rst: in std_logic;
            en_writing1 : in std_logic;
            done_writing1 : out std_logic
        );
    end component;

    component Write_0bit is 
        port (
            clk: in std_logic;
            rst: in std_logic;
            en_writing : in std_logic;
            done_writing : out std_logic
        );
    end component;
    
    component Timer_1us is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           timer1_start : in STD_LOGIC;
           timer1_done : out STD_LOGIC);
end component;


    signal sig_en_write0: std_logic;
    signal sig_en_write1 : std_logic;
    signal sig_done_wr0: std_logic;
    signal sig_done_wr1: std_logic;
    signal sig_en_timer1us: std_logic;
    signal sig_timer_done: std_logic;

    begin 
        write8bitfsm: Writebit 
        port map (
             clk => clk,
             rst => rst,
             start=> start_write, 
             data_in => word_data, 
             done=> done_write,
             write0 => sig_en_write0,
             write1 => sig_en_write1,
             done_writing1 => sig_done_wr1,
             done_writing0 => sig_done_wr0,
             oneus_flag => sig_timer_done,
             start1us_timer=> sig_en_timer1us,
              ONE_WIRE_OUT_W => ONE_WIRE_OUT
        );

        writeval1: write_1bit
            port map (
                clk => clk,
                rst => rst,
                en_writing1 => sig_en_write1,
                done_writing1=> sig_done_wr1
            );

        writeval0: write_0bit
            port map (
                clk => clk,
                rst => rst,
                en_writing => sig_en_write0,
                done_writing=> sig_done_wr0
            );
            
       timer1_us: Timer_1us
        port map (
                clk => clk,
                rst => rst,
                timer1_start => sig_en_timer1us,
                timer1_done=> sig_timer_done
            );
            
end Structural; 