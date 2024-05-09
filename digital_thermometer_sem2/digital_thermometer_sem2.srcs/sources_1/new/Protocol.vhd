----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 03:30:37 PM
-- Design Name: 
-- Module Name: Protocol - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use IEEE.NUMERIC_STD.ALL;


entity Protocol_FSM is
    Port ( rst          : in STD_LOGIC;
           clk          : in STD_LOGIC;
           start        : in STD_LOGIC;
           finish_init       : in STD_LOGIC;
           finish_write       : in STD_LOGIC;
           finish_read       : in STD_LOGIC;
           start_init   : out STD_LOGIC;
           start_write  : out STD_LOGIC;
           start_read   : out std_logic;
           data         : out STD_LOGIC_VECTOR (7 downto 0);
           done_p        : out STD_LOGIC;
           en_timer_800ms : out std_logic;
           done_timer_800ms: in std_logic
         );
end Protocol_FSM;

architecture Behavioral of Protocol_FSM is
signal count: integer range 0 to 2;
type states is (
     IDLE,
     INIT,
     WR_ROM,
     WR_SEQ,
     CONV_T, 
     ASK_VAL,
     READ_T,
     DONE
     );
     
signal next_state    : states;
signal present_state : states;

begin

    -- Block M 
    process(rst,clk)
        begin
        if (rst = '1') then
            present_state <= init;
        elsif rising_edge(clk) then
            present_state <= next_state;
        end if;
    end process;

    -- Block F of the Moore Machine
    process(present_state, start, finish_init, finish_read, finish_write,done_timer_800ms)
        begin
        case present_state is
        
        when IDLE => if (start = '1') then
                        next_state <= INIT;
                     else
                        next_state <= IDLE;
                     end if;
                     
        when INIT   => if (finish_init = '1') then
                            next_state <= WR_ROM;
                        else
                            next_state <= INIT;
                        end if;
        when WR_ROM => if (finish_write = '1') then
                          if(count = 1) then
                            next_state <= ASK_VAL;
                           else
                            next_state <= WR_SEQ;
                           end if;
                        else
                            next_state <= WR_ROM;
                        end if;
                 
        when WR_SEQ   => if (finish_write = '1') then
                            
                            next_state <= CONV_T;
                        else
                            next_state <= WR_SEQ;
                        end if;
        when ASK_VAL   => if (finish_write = '1') then
                            next_state <= READ_T;
                        else
                            next_state <= ASK_VAL;
                        end if;   
        when READ_T   => if (finish_read = '1') then
                            next_state <= INIT;
                        else
                            next_state <= READ_T;
                        end if;   
        when CONV_T   => if (done_timer_800ms = '1') then
                            next_state <= INIT;
                        else
                            next_state <= CONV_T;
                        end if;                  
                                    
        when others => next_state <= IDLE;
        end case;
    end process;
    
    -- Block G of the Moore Machine
    process(present_state)
        begin
        case present_state is
            --when init =>  -- Same as when others
            
            when IDLE => 
                start_init       <= '0';
                start_write      <= '0';
                start_read       <= '0';
                data             <= "00000000";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= 0;
            
            when INIT =>
                start_init       <= '1';
                start_write      <= '0';
                start_read       <= '0';
                data             <= "00000000";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= count;
                              
            when WR_ROM =>  
                start_init       <= '0';
                start_write      <= '1';
                start_read       <= '0';
                data             <= "11001100";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= count;
            when ASK_VAL =>  
                start_init       <= '0';
                start_write      <= '1';
                start_read       <= '0';
                data             <= "10111110";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= count;
            
            when WR_SEQ   => 
                start_init       <= '0';
                start_write      <= '1';
                start_read       <= '0';
                data             <= "01000100";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= count;
                             
            when CONV_T   => 
                start_init       <= '0';
                start_write      <= '0';
                start_read       <= '0';
                data             <= "00000000";
                done_p           <= '0';
                en_timer_800ms   <= '1';
                count            <= count + 1; 
            
            when READ_T   => 
                start_init       <= '0';
                start_write      <= '0';
                start_read       <= '1';
                data             <= "00000000";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= 0; 
            
            when others => 
                start_init       <= '0';
                start_write      <= '0';
                start_read       <= '0';
                data             <= "00000000";
                done_p           <= '0';
                en_timer_800ms   <= '0';
                count            <= 0;
        end case;
    end process;


end Behavioral;
