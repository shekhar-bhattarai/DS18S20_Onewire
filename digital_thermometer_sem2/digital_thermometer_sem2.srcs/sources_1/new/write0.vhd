-- write1 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity Write_0bit is 
    port (
        clk: in std_logic;
        rst: in std_logic;
        en_writing0 : in std_logic;
        done_timer_60us: in std_logic;
        
        done_writing0 : out std_logic;
        en_timer_60us: out std_logic
        
    );
end Write_0bit;

architecture Behavioral of Write_0bit is
type state_type is (
        IDLE, 
        START_W, 
        WRITE_0,
        DONE_W
    );
    
    -- State signal
    signal current_state, next_state : state_type;
    

begin


    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= IDLE; -- Initialize to initial state
        elsif rising_edge(clk) then
            current_state <= next_state; -- Update current state on clock edge
        end if;
        
    end process;


    process(current_state,clk,en_writing0,done_timer_60us)
    begin
        case current_state is
            when IDLE =>
                if en_writing0 = '1' then
                    next_state <= START_W;  -- Transition to START state on start signal
                    
                else 
                    next_state <= IDLE;
                
                end if;
                
            when START_W =>
                next_state <= WRITE_0;  -- Transition to write0 state
            when WRITE_0 => 
                if(done_timer_60us = '1') then 
                    next_state <= DONE_W;
                else 
                    next_state <= WRITE_0;
                end if;
                
            when DONE_W =>
                   next_state <= IDLE;
                          
            when others =>
                next_state <= IDLE;
                
        end case;
    end process;


    process(current_state) 
    begin
    case current_state is 
	   when IDLE => 
	      done_writing0 <= '0';
     en_timer_60us <= '0';

	when START_W =>
		done_writing0 <= '0';
        en_timer_60us <= '0';
  

    when WRITE_0 =>
        done_writing0 <= '0';
        en_timer_60us <= '1';
        
	when DONE_W => 
        done_writing0 <= '1';
        en_timer_60us <= '0';
        
    when others =>
        done_writing0 <= '0';
        en_timer_60us <= '0';
        
   end case;
end process; 

end Behavioral;