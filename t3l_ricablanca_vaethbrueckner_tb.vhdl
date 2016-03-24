-- Authors:
-- John Carlo G. Ricablanca
-- Jan-Josel C. Vaethbrueckner
-- T-3l

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t3l_ricablanca_vaethbrueckner_tb is
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns;
end entity;

architecture tb of t3l_ricablanca_vaethbrueckner_tb is

	component t3l_ricablanca_vaethbrueckner is
			port (alarm: out std_logic; boggis_in,boggis_out,bunce_in,bunce_out,bean_in,bean_out: in std_logic );
	end component;
	
	signal alarm: std_logic;
	signal boggis_in,boggis_out,bunce_in,bunce_out,bean_in,bean_out: std_logic;
	
begin --architecture

	uut: component t3l_ricablanca_vaethbrueckner port map(alarm, boggis_in,boggis_out,bunce_in,bunce_out,bean_in,bean_out);
	main: process is
	
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
			boggis_in <= temp(5);			
			boggis_out <= temp(4);
			bunce_in <= temp(3);
			bunce_out <= temp(2);
			bean_in <= temp(1);
			bean_out <= temp(0);

			wait for DELAY;

			if ( ((boggis_in or bunce_in or bean_in) and (boggis_out or bunce_out or bean_out)) = '1' ) then 
					expected_alarm := '1';
			else
				expected_alarm := '0';
			end if;
						
			assert(expected_alarm = alarm)
				report "ERROR: Expected Alarm " & std_logic'image(expected_alarm) & " /= actual alarm " & 
					std_logic'image(alarm) & " at time " & time'image(now);
				
			if  (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture tb;
