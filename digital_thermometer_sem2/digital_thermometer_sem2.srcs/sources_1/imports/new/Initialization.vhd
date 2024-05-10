----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2024 16:33:20
-- Design Name: 
-- Module Name: Initialization - Behavioral
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

entity Initialization is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           time_out480 : in STD_LOGIC;
           time_out60 : in STD_LOGIC;
           ONE_WIRE_IN : in STD_LOGIC;
           ONE_WIRE_OUT : out STD_LOGIC;
           en_timer480: out STD_LOGIC;
           en_timer60: out STD_LOGIC;
           
           sens_detect: out std_logic;
           done_init : out std_logic
           
             );
end Initialization;

architecture Behavioral of Initialization is

type state is (INIT,Master_Tx,Wait_Rx,Master_Rx,Slave_Tx, Slave_Pr);
signal nstate, pstate: state;
begin

block_F: process(clk, rst)
begin
  if (rst='1') then
    pstate<=INIT;
  elsif rising_edge(clk) then
      pstate<= nstate;    
    end if;
end process block_F;

block_M: process(pstate,clk,start,time_out480,time_out60,one_wire_in)      --enter only i/p 
begin
   case(pstate) is
        when INIT => 
            if (start='1') then 
                nstate <=Master_Tx;
            else
                nstate<= INIT;
             end if;   
        when Master_Tx => 
             if (time_out480='1') then
                 nstate<=Wait_rx;
              else
                nstate<= Master_Tx;
              end if;
                  
         when Wait_rx =>
              if (time_out60='1') then
                 nstate<=Master_Rx;
               else
                nstate<= Wait_rx;
              end if;
            
         when  Master_Rx=>
            
            if( ONE_WIRE_IN ='0') then
                nstate<=Slave_Tx;
            elsif (time_out480='1') then
                nstate<=INIT;
            else
                nstate<= Master_Rx;
            end if;  
            
            
          when Slave_Tx =>
                       
             if( time_out60 ='1') then 
                if(ONE_WIRE_IN ='0') then 
                    nstate<=Slave_Pr;
                end if;
              elsif(time_out480 ='1') then
                     nstate <= INIT;
              else
                nstate<= Slave_Tx;
             end if;
             
             when Slave_Pr =>
                if( time_out480='1') then
                 nstate<= INIT;

                 else 
                    nstate<=Slave_Pr;                  
              end if;
             when others =>
                nstate<=INIT;  
                 
         end case; 
end process;      
            
                    
    --in next process initialize the o/p 
    
 --output blocks
 
         block_G: Process(pstate)
            begin
                case pstate is 
                    
                    when INIT => 
                            ONE_WIRE_OUT    <='1';
                             en_timer480    <='0';  --480timer--enable timer count for 480micsecs
                             en_timer60     <='0';
                             sens_detect    <='0';
                             done_init      <= '0';
                            
                                  
                    when Master_Tx => 
                                    ONE_WIRE_OUT    <='0';
                                    en_timer60      <='0';  --480timer--enable timer count for 480micsecs
                                    en_timer480     <='1';
                                     sens_detect    <='0';
                                    done_init       <='0';
                       -- from here to the end of the process is 480 us              
                    when Wait_rx => 
                                  ONE_WIRE_OUT  <='1';
                                  en_timer480   <='1';
                                  en_timer60    <='1';
                                  sens_detect   <='0';
                                  done_init     <= '0';
                                  
                                  
                    when Master_Rx => 
                                  ONE_WIRE_OUT  <='1';
                                  en_timer60    <='0';  
                                  sens_detect   <='0'; 
                                  done_init     <= '0';
                                  en_timer480     <='1';
                                           
                     when Slave_Tx => 
                                  ONE_WIRE_OUT  <='1';
                                  en_timer60    <='1';  --count to 60is enabled
                                  
                                  sens_detect   <='0';
                                  done_init     <= '0';
                      when Slave_Pr => 
                                  ONE_WIRE_OUT  <='1';
                                  en_timer60    <='0';  --count to 60is enabled
                                  sens_detect   <='1';
                                  done_init     <='1';
                      
                      when others =>  
                                 ONE_WIRE_OUT<='1';
                                 en_timer480 <='0'; 
                                 en_timer60 <='0';
                                 sens_detect <='0';
                                 done_init <= '0';
                                 
                    
                    end case;
                     
                    
            end process;  



               
end Behavioral;
