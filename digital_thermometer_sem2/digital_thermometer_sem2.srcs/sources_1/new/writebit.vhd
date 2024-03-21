library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Writebit is
    Port (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        start : in STD_LOGIC;
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        done_writing1: in std_logic;
        done_writing0 : in std_logic;
        oneus_flag: in std_logic;
        
        done : out STD_LOGIC;
        write0 : out STD_LOGIC;
        write1 : out STD_LOGIC;
        start1us_timer : out std_logic;
        ONE_WIRE_OUT_W : out std_logic
    );
end Writebit;

architecture Behavioral of Writebit is

    type state_type is (
        IDLE, 
        START_S, 
        WAIT_1US,
        TRANSMIT_DATA,
        WRITE_0,
        WRITE_1,
        COUNT_VAL,
        DONE_S
    );
    
    -- State signal
    signal current_state, next_state : state_type;
    
    -- Counter for tracking the bit index
    signal bit_index : integer range 0 to 7 := 0;


begin


    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= IDLE; -- Initialize to initial state
        elsif rising_edge(clk) then
            current_state <= next_state; -- Update current state on clock edge
        end if;
        
    end process;


    process(current_state,clk,start,oneus_flag,done_writing1,done_writing0)
    begin
        case current_state is
            when IDLE =>
                if start = '1' then
                    next_state <= START_S;  -- Transition to START state on start signal
                    
                else 
                    next_state <= IDLE;
                
                end if;
                
            when START_S =>
                next_state <= WAIT_1US;  -- Transition to TRANSMIT_DATA state
            when WAIT_1US => 
                if(Oneus_flag = '1') then 
                    next_state <= TRANSMIT_DATA;
                end if;
            when TRANSMIT_DATA =>
                if bit_index < 8 then
                    if data_in(bit_index) = '1' then
                        next_state <= WRITE_1;  -- Transition to WRITE_1 state if bit is '1'
                    else
                        next_state <= WRITE_0;  -- Transition to WRITE_0 state if bit is '0'
                    end if;
                else
                    next_state <= DONE_S;  -- Transition to DONE state after transmitting all 8 bits
                end if;
                when WRITE_0 =>
                    if(done_writing0 = '1') then 
                        next_state <= WAIT_1US;  -- Transition back to waitstate state
                    else 
                        next_state <= Write_0;  -- stay here until receive feedback
                    end if; 
            when WRITE_1 =>
                if(done_writing1 = '1') then 
                    next_state <= WAIT_1US;  -- Transition back to TRANSMIT_DATA state
                else 
                    next_state <= Write_1;
                end if;
            when DONE_S =>
                next_state <= IDLE;  -- Transition back to IDLE state
            when others =>
                next_state <= IDLE;
        end case;
    end process;


    process(current_state) 
    begin
    case current_state is 
	   when IDLE => 
		bit_index <= 0; -- Reset bit index
        done <= '0';    -- Clear done signal
        write0 <= '0';  -- Clear write0 signal
        write1 <= '0';  -- Clear write1 signal
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '1';

	when START_S =>
		bit_index <= 0; -- bit index SET TO 0
        done <= '0';    -- done signal IS LOW
        write0 <= '0';  -- write0 signal
        write1 <= '0';  -- write1 signal
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '1';

    when WAIT_1US =>
        done <= '0'; 
        write0 <= '0'; 
        write1 <= '0';
        start1us_timer <= '1';
        ONE_WIRE_OUT_W <= '1';

	when TRANSMIT_DATA =>
        done <= '0';
        write0 <= '0'; 
        write1 <= '0';
		bit_index <= bit_index + 1; --COUNT BIT NUMBER
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '1';
        
	when WRITE_0 =>
		write0 <= '1';  -- Set write0 signal
        write1 <= '0';  -- Clear write1 signal
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '0';
        
	when WRITE_1 => 
		write0 <= '0';  -- Set write0 signal
        write1 <= '1';  -- Clear write1 signal
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '0';

	when DONE_S =>
		done <= '1'; 
        start1us_timer <= '0';
        write0 <= '0'; 
        write1 <= '0';
        ONE_WIRE_OUT_W <= '1';
    when others =>bit_index <= 0; -- Reset bit index
        done <= '0';    -- Clear done signal
        write0 <= '0';  -- Clear write0 signal
        write1 <= '0';  -- Clear write1 signal
        start1us_timer <= '0';
        ONE_WIRE_OUT_W <= '1'; 
   end case;
end process; 
end Behavioral;
