----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2024 12:00:21 AM
-- Design Name: 
-- Module Name: Read0bit - Behavioral
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


entity Read1bit is 
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
        write_bit : out std_logic;
        write_mem : out std_logic;
        done_reading : out std_logic        
    );
    end Read1bit;
    
    
architecture Behavioral of Read1bit is

    type state_type is (
        IDLE, 
        PULLDOWN,
        WAIT_15US, 
        READ_LINE,
        OUT_0,
        OUT_1,
        WAIT_SLOT,
        WAIT_SLOT2,
        DONE_R
    );
    
    -- State signal
    signal current_state, next_state : state_type;
     signal count_8bit : integer range 0 to 7 := 0;

begin


    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= IDLE; -- Initialize to initial state
        elsif rising_edge(clk) then
            current_state <= next_state; -- Update current state on clock edge
        end if;
        
    end process;


    process(current_state,clk,rst)
    begin
        case current_state is
            when IDLE =>
                if start_reading = '1' then
                    next_state <= PULLDOWN;  -- Transition to START state on start signal
                    
                else 
                    next_state <= IDLE;
                
                end if;

            when PULLDOWN => 
                if count_8bit < 8 then
                
                    if(timer_1us_done = '1') then 
                        next_state <= WAIT_15US;
                    else 
                        next_state <= PULLDOWN;
                    end if;
                else
                    next_state <= DONE_R;
               end if;
               
            when WAIT_15US => 
                if(timer_15us_done = '1') then 
                    next_state <= READ_LINE;
                else 
                    next_state <= WAIT_15US;
                end if;
                
            when READ_LINE =>
             if(Read_wire = '0') then 
                    next_state <= OUT_0;
                else 
                    next_state <= OUT_1;
                end if;
             when OUT_0 => 
             
                next_state <= WAIT_SLOT;
             when OUT_1 => 
                next_state <= WAIT_SLOT;
             when WAIT_SLOT => 
                if(timer_60us_done = '1') then
                    next_state <= WAIT_SLOT2;
                else 
                    next_state <= WAIT_SLOT;
                end if;
                when WAIT_SLOT2 => 
                if(timer_1us_done = '1') then
                    next_state <= PULLDOWN;
                else 
                    next_state <= WAIT_SLOT2;
                end if;
             when DONE_R =>
                    next_state <= IDLE;           
            when others =>
                next_state <= IDLE;
                
        end case;
    end process;


    process(current_state) 
    begin
    case current_state is 
	   when IDLE => 
	        en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='0';
            write_bit       <='0'; 
            write_mem       <='0';
            pulldown_out <='1';
            count_8bit <= 0;
            done_reading <= '0';
            
	   when PULLDOWN =>
		    en_timer_1us    <='1';
            en_timer_15us   <='0';
            en_timer_60us   <='1';
            write_bit       <='0';
            write_mem       <='0';
            pulldown_out    <='0';
            done_reading <= '0';
            


	    when WAIT_15US => 
            en_timer_1us    <='0';
            en_timer_15us   <='1';
            en_timer_60us   <='1';
            write_bit       <='0'; 
            write_mem       <='0';
            pulldown_out    <='1';
            done_reading <= '0';
            
        when READ_LINE =>
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='1';
            write_bit       <='0'; 
            write_mem       <='0';
            pulldown_out    <='1';
            done_reading <= '0';
            
        when OUT_0 =>
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='1';
            write_bit       <='0';
            write_mem       <='1';
            pulldown_out    <='1';
            done_reading <= '0'; 
 
        when OUT_1 =>
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='1';
            write_bit       <='1';
            write_mem       <='1';
            pulldown_out    <='1'; 
            done_reading <= '0';

        when WAIT_SLOT =>
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='1';
            write_bit       <='0';
            write_mem       <='0';
            pulldown_out    <='1';
            done_reading <= '0';
            
        when WAIT_SLOT2 =>
            en_timer_1us    <='1';
            en_timer_15us   <='0';
            en_timer_60us   <='0';
            write_bit       <='0';
            write_mem       <='0';
            pulldown_out    <='1';  
            count_8bit      <= count_8bit +1;
            done_reading <= '0';
 
        when DONE_R => 
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='0';
            write_bit       <='0'; 
            write_mem       <='0';
            pulldown_out    <='1';
            done_reading <= '1';
        when others =>
            en_timer_1us    <='0';
            en_timer_15us   <='0';
            en_timer_60us   <='0';
            write_bit       <='0';
            pulldown_out    <='1'; 
            done_reading <= '0';

   end case;
end process; 

end Behavioral;