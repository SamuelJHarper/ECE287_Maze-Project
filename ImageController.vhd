LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.numeric_std.ALL;

ENTITY ImageController IS
	GENERIC(
		pixels_y :	INTEGER := 478;    --row that first color will persist until
		pixels_x	:	INTEGER := 600);   --column that first color will persist until
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		up				:  IN    STD_LOGIC;
		down			:  IN		STD_LOGIC;
		moveLeft 	:  IN    STD_LOGIC;
		moveRight	:  IN		STD_LOGIC;
		clk2			:  IN		STD_LOGIC;
		
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END ImageController;

ARCHITECTURE behavior OF ImageController IS
	
	signal centerX : integer range 0 to 2000:= (100);
	signal centerY : integer range 0 to 2000:= (979);
	signal counter : std_logic_vector(30 downto 0);  -- signal that does the counting
	signal counter2 : std_logic_vector(30 downto 0);  -- signal that does the counting
	

BEGIN
	PROCESS(disp_ena, row, column, centerX, centerY)
	BEGIN
		IF(disp_ena = '1') THEN		--display time
			IF (((row > centerX - 20) AND (row < centerX + 20) AND (column > centerY - 20) AND (column < centerY + 20))) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '1');
			--Maze Display
			ELSIF(((row > 0 AND row < 487) AND (column > 915 AND column < 950)) OR ((row > 570 AND row < 1170) AND (column > 915 AND column < 950)) OR ((row > 1125 AND row < 1170) AND (column > 695 AND column < 950)) OR ((row > 135 AND row < 1060) AND (column > 800 AND column < 840)) OR ((row > 1020 AND row < 1060) AND (column > 695 AND column < 840)) OR ((row > 135 AND row < 1060) AND (column > 695 AND column < 740)) OR ((row > 245 AND row < 1250) AND (column > 585 AND column < 630)) OR ((row > 135 AND row < 180) AND (column > 375 AND column < 630)) OR ((row > 135 AND row < 560) AND (column > 375 AND column < 415)) OR ((row > 245 AND row < 1170) AND (column > 485 AND column < 525)) OR ((row > 1125 AND row < 1170) AND (column > 250 AND column < 525)) OR ((row > 640 AND row < 1065) AND (column > 375 AND column < 415)) OR ((row > 910 AND row < 950) AND (column > 250 AND column < 415)) OR ((row > 910 AND row < 1170) AND (column > 250 AND column < 295)) OR ((row > 135 AND row < 815) AND (column > 250 AND column < 295)) OR ((row > 135 AND row < 175) AND (column > 0 AND column < 295)) OR ((row > 250 AND row < 1170) AND (column > 130 AND column < 175)) OR ((row > 405 AND row < 445) AND (column > 130 AND column < 295)) OR ((row > 310 AND row < 355) AND (column > 825 AND column < 920)) OR ((row > 20 AND row < 135) AND (column > 485 AND column < 525)) OR ((row > 1 AND row < 1279) AND (column > 1 AND column < 40)) OR ((row > 1 AND row < 40) AND (column > 1 AND column < 1023)) OR ((row > 1240 AND row < 1279) AND (column > 1 AND column < 1023)) OR ((row > 1 AND row < 1279) AND (column > 1004 AND column < 1023))) THEN
				red <= (OTHERS => '1');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			--Goal Point
			ELSIF((row > 340 AND row < 380) AND (column > 195 AND column < 230)) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '0');
			ELSE
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(up, down,clk2) --Up down controls
	BEGIN
		IF clk2'event and clk2 = '1' then  -- rising clock edge
			
			IF counter < "100110001001011010000" THEN
				counter <= counter + 1;
			ELSE
				IF (up = '1' AND down = '0') AND (centerY <980) AND NOT(((centerY + 1 >915-20 AND centerY + 1 < 950+ 20) AND (centerX > 0 - 20 AND centerX < 487 + 20))) AND NOT(((centerY + 1 >915-20 AND centerY + 1 < 950+ 20) AND (centerX > 570 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >695-20 AND centerY + 1 < 950+ 20) AND (centerX > 1125 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >800-20 AND centerY + 1 < 840+ 20) AND (centerX > 135 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY + 1 >695-20 AND centerY + 1 < 840+ 20) AND (centerX > 1020 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY + 1 >695-20 AND centerY + 1 < 740+ 20) AND (centerX > 135 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY + 1 >585-20 AND centerY + 1 < 630+ 20) AND (centerX > 245 - 20 AND centerX < 1250 + 20))) AND NOT(((centerY + 1 >375-20 AND centerY + 1 < 630+ 20) AND (centerX > 135 - 20 AND centerX < 180 + 20))) AND NOT(((centerY + 1 >375-20 AND centerY + 1 < 415+ 20) AND (centerX > 135 - 20 AND centerX < 560 + 20))) AND NOT(((centerY + 1 >485-20 AND centerY + 1 < 525+ 20) AND (centerX > 245 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >250-20 AND centerY + 1 < 525+ 20) AND (centerX > 1125 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >375-20 AND centerY + 1 < 415+ 20) AND (centerX > 640 - 20 AND centerX < 1065 + 20))) AND NOT(((centerY + 1 >250-20 AND centerY + 1 < 415+ 20) AND (centerX > 910 - 20 AND centerX < 950 + 20))) AND NOT(((centerY + 1 >250-20 AND centerY + 1 < 295+ 20) AND (centerX > 910 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >250-20 AND centerY + 1 < 295+ 20) AND (centerX > 135 - 20 AND centerX < 815 + 20))) AND NOT(((centerY + 1 >0-20 AND centerY + 1 < 295+ 20) AND (centerX > 135 - 20 AND centerX < 175 + 20))) AND NOT(((centerY + 1 >130-20 AND centerY + 1 < 175+ 20) AND (centerX > 250 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY + 1 >130-20 AND centerY + 1 < 295+ 20) AND (centerX > 405 - 20 AND centerX < 445 + 20))) AND NOT(((centerY + 1 >825-20 AND centerY + 1 < 920+ 20) AND (centerX > 310 - 20 AND centerX < 355 + 20))) AND NOT(((centerY + 1 >485-20 AND centerY + 1 < 525+ 20) AND (centerX > 20 - 20 AND centerX < 135 + 20))) AND NOT(((centerY + 1 >0-20 AND centerY + 1 < 40+ 20) AND (centerX > 0 - 20 AND centerX < 1280 + 20))) AND NOT(((centerY + 1 >0-20 AND centerY + 1 < 1080+ 20) AND (centerX > 0 - 20 AND centerX < 40 + 20))) AND NOT(((centerY + 1 >0-20 AND centerY + 1 < 1080+ 20) AND (centerX > 1240 - 20 AND centerX < 1280 + 20))) AND NOT(((centerY + 1 >1060-20 AND centerY + 1 < 1080+ 20) AND (centerX > 0 - 20 AND centerX < 1280 + 20))) THEN
					centerY <= centerY + 1;
				ELSIF (up = '0' AND down = '1') AND (centerY > 40) AND NOT(((centerY - 1 >915-20 AND centerY - 1 < 950+ 20) AND (centerX > 0 - 20 AND centerX < 487 + 20))) AND NOT(((centerY - 1 >915-20 AND centerY - 1 < 950+ 20) AND (centerX > 570 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >695-20 AND centerY - 1 < 950+ 20) AND (centerX > 1125 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >800-20 AND centerY - 1 < 840+ 20) AND (centerX > 135 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY - 1 >695-20 AND centerY - 1 < 840+ 20) AND (centerX > 1020 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY - 1 >695-20 AND centerY - 1 < 740+ 20) AND (centerX > 135 - 20 AND centerX < 1060 + 20))) AND NOT(((centerY - 1 >585-20 AND centerY - 1 < 630+ 20) AND (centerX > 245 - 20 AND centerX < 1250 + 20))) AND NOT(((centerY - 1 >375-20 AND centerY - 1 < 630+ 20) AND (centerX > 135 - 20 AND centerX < 180 + 20))) AND NOT(((centerY - 1 >375-20 AND centerY - 1 < 415+ 20) AND (centerX > 135 - 20 AND centerX < 560 + 20))) AND NOT(((centerY - 1 >485-20 AND centerY - 1 < 525+ 20) AND (centerX > 245 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >250-20 AND centerY - 1 < 525+ 20) AND (centerX > 1125 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >375-20 AND centerY - 1 < 415+ 20) AND (centerX > 640 - 20 AND centerX < 1065 + 20))) AND NOT(((centerY - 1 >250-20 AND centerY - 1 < 415+ 20) AND (centerX > 910 - 20 AND centerX < 950 + 20))) AND NOT(((centerY - 1 >250-20 AND centerY - 1 < 295+ 20) AND (centerX > 910 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >250-20 AND centerY - 1 < 295+ 20) AND (centerX > 135 - 20 AND centerX < 815 + 20))) AND NOT(((centerY - 1 >0-20 AND centerY - 1 < 295+ 20) AND (centerX > 135 - 20 AND centerX < 175 + 20))) AND NOT(((centerY - 1 >130-20 AND centerY - 1 < 175+ 20) AND (centerX > 250 - 20 AND centerX < 1170 + 20))) AND NOT(((centerY - 1 >130-20 AND centerY - 1 < 295+ 20) AND (centerX > 405 - 20 AND centerX < 445 + 20))) AND NOT(((centerY - 1 >825-20 AND centerY - 1 < 920+ 20) AND (centerX > 310 - 20 AND centerX < 355 + 20))) AND NOT(((centerY - 1 >485-20 AND centerY - 1 < 525+ 20) AND (centerX > 20 - 20 AND centerX < 135 + 20))) AND NOT(((centerY - 1 >0-20 AND centerY - 1 < 40+ 20) AND (centerX > 0 - 20 AND centerX < 1280 + 20))) AND NOT(((centerY - 1 >0-20 AND centerY - 1 < 1080+ 20) AND (centerX > 0 - 20 AND centerX < 40 + 20))) AND NOT(((centerY - 1 >0-20 AND centerY - 1 < 1080+ 20) AND (centerX > 1240 - 20 AND centerX < 1280 + 20))) AND NOT(((centerY - 1 >1060-20 AND centerY - 1 < 1080+ 20) AND (centerX > 0 - 20 AND centerX < 1280 + 20))) THEN
					centerY <= centerY-1;
				END IF;
				counter <= (others => '0');
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(up, down, clk2) --Up down controls
	BEGIN
		IF clk2'event and clk2 = '1' then  -- rising clock edge
			
			IF counter2 < "100110001001011010000" THEN
				counter2 <= counter2 + 1;
			ELSE
				IF (moveLeft = '1' AND moveRight = '0') AND (centerX <1240) AND NOT(((centerX + 1 >0-20 AND centerX + 1 < 487+ 20) AND (centerY > 915 - 20 AND centerY < 950 + 20))) AND NOT(((centerX + 1 >570-20 AND centerX + 1 < 1170+ 20) AND (centerY > 915 - 20 AND centerY < 950 + 20))) AND NOT(((centerX + 1 >1125-20 AND centerX + 1 < 1170+ 20) AND (centerY > 695 - 20 AND centerY < 950 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 1060+ 20) AND (centerY > 800 - 20 AND centerY < 840 + 20))) AND NOT(((centerX + 1 >1020-20 AND centerX + 1 < 1060+ 20) AND (centerY > 695 - 20 AND centerY < 840 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 1060+ 20) AND (centerY > 695 - 20 AND centerY < 740 + 20))) AND NOT(((centerX + 1 >245-20 AND centerX + 1 < 1250+ 20) AND (centerY > 585 - 20 AND centerY < 630 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 180+ 20) AND (centerY > 375 - 20 AND centerY < 630 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 560+ 20) AND (centerY > 375 - 20 AND centerY < 415 + 20))) AND NOT(((centerX + 1 >245-20 AND centerX + 1 < 1170+ 20) AND (centerY > 485 - 20 AND centerY < 525 + 20))) AND NOT(((centerX + 1 >1125-20 AND centerX + 1 < 1170+ 20) AND (centerY > 250 - 20 AND centerY < 525 + 20))) AND NOT(((centerX + 1 >640-20 AND centerX + 1 < 1065+ 20) AND (centerY > 375 - 20 AND centerY < 415 + 20))) AND NOT(((centerX + 1 >910-20 AND centerX + 1 < 950+ 20) AND (centerY > 250 - 20 AND centerY < 415 + 20))) AND NOT(((centerX + 1 >910-20 AND centerX + 1 < 1170+ 20) AND (centerY > 250 - 20 AND centerY < 295 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 815+ 20) AND (centerY > 250 - 20 AND centerY < 295 + 20))) AND NOT(((centerX + 1 >135-20 AND centerX + 1 < 175+ 20) AND (centerY > 0 - 20 AND centerY < 295 + 20))) AND NOT(((centerX + 1 >250-20 AND centerX + 1 < 1170+ 20) AND (centerY > 130 - 20 AND centerY < 175 + 20))) AND NOT(((centerX + 1 >405-20 AND centerX + 1 < 445+ 20) AND (centerY > 130 - 20 AND centerY < 295 + 20))) AND NOT(((centerX + 1 >310-20 AND centerX + 1 < 355+ 20) AND (centerY > 825 - 20 AND centerY < 920 + 20))) AND NOT(((centerX + 1 >20-20 AND centerX + 1 < 135+ 20) AND (centerY > 485 - 20 AND centerY < 525 + 20))) AND NOT(((centerX + 1 >0-20 AND centerX + 1 < 1280+ 20) AND (centerY > 0 - 20 AND centerY < 40 + 20))) AND NOT(((centerX + 1 >0-20 AND centerX + 1 < 40+ 20) AND (centerY > 0 - 20 AND centerY < 1080 + 20))) AND NOT(((centerX + 1 >1240-20 AND centerX + 1 < 1280+ 20) AND (centerY > 0 - 20 AND centerY < 1080 + 20))) AND NOT(((centerX + 1 >0-20 AND centerX + 1 < 1280+ 20) AND (centerY > 1060 - 20 AND centerY < 1080 + 20))) THEN
					centerX <= centerX + 1;
				ELSIF (moveLeft = '0' AND moveRight = '1') AND (centerX > 40) AND NOT(((centerX - 1 >0-20 AND centerX - 1 < 487+ 20) AND (centerY > 915 - 20 AND centerY < 950 + 20))) AND NOT(((centerX - 1 >570-20 AND centerX - 1 < 1170+ 20) AND (centerY > 915 - 20 AND centerY < 950 + 20))) AND NOT(((centerX - 1 >1125-20 AND centerX - 1 < 1170+ 20) AND (centerY > 695 - 20 AND centerY < 950 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 1060+ 20) AND (centerY > 800 - 20 AND centerY < 840 + 20))) AND NOT(((centerX - 1 >1020-20 AND centerX - 1 < 1060+ 20) AND (centerY > 695 - 20 AND centerY < 840 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 1060+ 20) AND (centerY > 695 - 20 AND centerY < 740 + 20))) AND NOT(((centerX - 1 >245-20 AND centerX - 1 < 1250+ 20) AND (centerY > 585 - 20 AND centerY < 630 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 180+ 20) AND (centerY > 375 - 20 AND centerY < 630 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 560+ 20) AND (centerY > 375 - 20 AND centerY < 415 + 20))) AND NOT(((centerX - 1 >245-20 AND centerX - 1 < 1170+ 20) AND (centerY > 485 - 20 AND centerY < 525 + 20))) AND NOT(((centerX - 1 >1125-20 AND centerX - 1 < 1170+ 20) AND (centerY > 250 - 20 AND centerY < 525 + 20))) AND NOT(((centerX - 1 >640-20 AND centerX - 1 < 1065+ 20) AND (centerY > 375 - 20 AND centerY < 415 + 20))) AND NOT(((centerX - 1 >910-20 AND centerX - 1 < 950+ 20) AND (centerY > 250 - 20 AND centerY < 415 + 20))) AND NOT(((centerX - 1 >910-20 AND centerX - 1 < 1170+ 20) AND (centerY > 250 - 20 AND centerY < 295 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 815+ 20) AND (centerY > 250 - 20 AND centerY < 295 + 20))) AND NOT(((centerX - 1 >135-20 AND centerX - 1 < 175+ 20) AND (centerY > 0 - 20 AND centerY < 295 + 20))) AND NOT(((centerX - 1 >250-20 AND centerX - 1 < 1170+ 20) AND (centerY > 130 - 20 AND centerY < 175 + 20))) AND NOT(((centerX - 1 >405-20 AND centerX - 1 < 445+ 20) AND (centerY > 130 - 20 AND centerY < 295 + 20))) AND NOT(((centerX - 1 >310-20 AND centerX - 1 < 355+ 20) AND (centerY > 825 - 20 AND centerY < 920 + 20))) AND NOT(((centerX - 1 >20-20 AND centerX - 1 < 135+ 20) AND (centerY > 485 - 20 AND centerY < 525 + 20))) AND NOT(((centerX - 1 >0-20 AND centerX - 1 < 1280+ 20) AND (centerY > 0 - 20 AND centerY < 40 + 20))) AND NOT(((centerX - 1 >0-20 AND centerX - 1 < 40+ 20) AND (centerY > 0 - 20 AND centerY < 1080 + 20))) AND NOT(((centerX - 1 >1240-20 AND centerX - 1 < 1280+ 20) AND (centerY > 0 - 20 AND centerY < 1080 + 20))) AND NOT(((centerX - 1 >0-20 AND centerX - 1 < 1280+ 20) AND (centerY > 1060 - 20 AND centerY < 1080 + 20))) THEN
					centerX <= centerX-1;
				END IF;
				counter2 <= (others => '0');
			END IF;
		END IF;
	END PROCESS;
END behavior;


