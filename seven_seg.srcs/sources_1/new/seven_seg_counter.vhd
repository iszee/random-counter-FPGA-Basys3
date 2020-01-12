library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity seven_seg_counter is
    Port ( clock_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC; 
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));
end seven_seg_counter;


architecture Behavioral of seven_seg_counter is

signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
signal LED_activating_counter: std_logic_vector(1 downto 0);
begin
displayed_number <= "1000000000111111";

process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => LED_out <= "0000001";  
    when "0001" => LED_out <= "1001111"; 
    when "0010" => LED_out <= "0010010";  
    when "0011" => LED_out <= "0000110"; 
    when "0100" => LED_out <= "1001100";  
    when "0101" => LED_out <= "0100100";  
    when "0110" => LED_out <= "0100000";  
    when "0111" => LED_out <= "0001111";  
    when "1000" => LED_out <= "0000000";      
    when "1001" => LED_out <= "0000100";  
    when "1010" => LED_out <= "0000010"; 
    when "1011" => LED_out <= "1100000"; 
    when "1100" => LED_out <= "0110001"; 
    when "1101" => LED_out <= "1000010"; 
    when "1110" => LED_out <= "0110000"; 
    when "1111" => LED_out <= "0111000"; 
    end case;
end process;


process(clock_100Mhz,reset)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clock_100Mhz)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;


LED_activating_counter <= refresh_counter(19 downto 18);
 
 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        LED_BCD <= displayed_number(15 downto 12);
    when "01" =>
        Anode_Activate <= "1011"; 
        LED_BCD <= displayed_number(11 downto 8);
    when "10" =>
        Anode_Activate <= "1101"; 
        LED_BCD <= displayed_number(7 downto 4);
    when "11" =>
        Anode_Activate <= "1110"; 
        LED_BCD <= displayed_number(3 downto 0); 
    end case;
end process;


end Behavioral;