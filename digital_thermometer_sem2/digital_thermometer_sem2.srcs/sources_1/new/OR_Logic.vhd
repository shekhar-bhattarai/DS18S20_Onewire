----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2024 09:51:28 PM
-- Design Name: 
-- Module Name: OR_Logic - Behavioral
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
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity declaration

entity orGate is

    port(A : in std_logic;      -- OR gate input
         B : in std_logic;      -- OR gate input
         Y : out std_logic);    -- OR gate output

end orGate;

-- Dataflow Modelling Style
-- Architecture definition

architecture orLogic of orGate is

 begin
    
    Y <= A OR B;

end orLogic;
