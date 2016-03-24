-- Authors:
-- John Carlo G. Ricablanca
-- Jan-Josel C. Vaethbrueckner
-- T-3l

library IEEE; use IEEE.std_logic_1164.all;

entity t3l_ricablanca_vaethbrueckner is
	port (alarm: out std_logic; boggis_in,boggis_out,bunce_in,bunce_out,bean_in,bean_out: in std_logic );
end t3l_ricablanca_vaethbrueckner;

architecture behav of t3l_ricablanca_vaethbrueckner is
begin 

	alarm <= (boggis_out and boggis_in) or (bunce_in and boggis_out) or (bunce_out and boggis_in) or (bunce_out and bunce_in) or 
		(bean_in and boggis_out) or (bean_in and bunce_out) or (bean_out and boggis_in) or (bean_out and bunce_in) or (bean_out and bean_in);	
	
end architecture behav;	
