::CODED BY KSH/AXSYS
:z
REM @echo on
@echo off
call :logo
set ver=3.8
cd %temp%
REM if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
setlocal EnableDelayedExpansion
if not exist %appdata%\KSH-Soft\PingMetter\ (
	mkdir %appdata%\KSH-Soft\PingMetter\
)
if not exist batbox.exe goto bb
::################################################
if not exist %appdata%\KSH-Soft\PingMetter\Link1 (
	echo .>%appdata%\KSH-Soft\PingMetter\Link1
)
if not exist %appdata%\KSH-Soft\PingMetter\Link2 (
	echo .>%appdata%\KSH-Soft\PingMetter\Link2
)
if not exist %appdata%\KSH-Soft\PingMetter\Link3 (
	echo .>%appdata%\KSH-Soft\PingMetter\Link3
)
if not exist %appdata%\KSH-Soft\PingMetter\Link4 (
	echo .>%appdata%\KSH-Soft\PingMetter\Link4
)
if not exist %appdata%\KSH-Soft\PingMetter\Link5 (
	echo .>%appdata%\KSH-Soft\PingMetter\Link5
)
if not exist %appdata%\KSH-Soft\PingMetter\MAD (
	echo 0 >%appdata%\KSH-Soft\PingMetter\MAD
)
if not exist %appdata%\KSH-Soft\PingMetter\MCP (
	echo 0 >%appdata%\KSH-Soft\PingMetter\MCP
)
if not exist %appdata%\KSH-Soft\PingMetter\scp1 (
	echo 20 >%appdata%\KSH-Soft\PingMetter\scp1
)
if not exist %appdata%\KSH-Soft\PingMetter\scp2 (
	echo 35 >%appdata%\KSH-Soft\PingMetter\scp2
)
if not exist %appdata%\KSH-Soft\PingMetter\scp3 (
	echo 75 >%appdata%\KSH-Soft\PingMetter\scp3
)
if not exist %appdata%\KSH-Soft\PingMetter\scp4 (
	echo 100 >%appdata%\KSH-Soft\PingMetter\scp4
)
if not exist %appdata%\KSH-Soft\PingMetter\scp5 (
	echo 200 >%appdata%\KSH-Soft\PingMetter\scp5
)

::################################################
set /p link1=<%appdata%\KSH-Soft\PingMetter\Link1
set /p link2=<%appdata%\KSH-Soft\PingMetter\Link2
set /p link3=<%appdata%\KSH-Soft\PingMetter\Link3
set /p link4=<%appdata%\KSH-Soft\PingMetter\Link4
set /p link5=<%appdata%\KSH-Soft\PingMetter\Link5
set /p MCP=<%appdata%\KSH-Soft\PingMetter\MCP
set /p MAD=<%appdata%\KSH-Soft\PingMetter\MAD
set /p scp1=<%appdata%\KSH-Soft\PingMetter\scp1
set /p scp2=<%appdata%\KSH-Soft\PingMetter\scp2
set /p scp3=<%appdata%\KSH-Soft\PingMetter\scp3
set /p scp4=<%appdata%\KSH-Soft\PingMetter\scp4
set /p scp5=<%appdata%\KSH-Soft\PingMetter\scp5
:a
call :logo
call :linksss
echo,
echo (Or #?^|r/R=Reset)
set /p adrs=" [IP or ex: google.fr] Pinged adress  : "
::##################
if '%adrs%' == 'r' (
	echo O|rmdir /s %appdata%\KSH-Soft\PingMetter\
	goto z
)
if '%adrs%' == 'R' (
	echo O|rmdir /s %appdata%\KSH-Soft\PingMetter\
	goto z
)
if '%adrs%' == 'setup' (
	goto settings
)
if '%adrs%' == 'SETUP' (
	goto settings
)
if '%adrs%' == 's' (
	goto settings
)
if '%adrs%' == 'S' (
	goto settings
)

if %adrs% == 1 (
	set adrs=%link1%
)
if %adrs% == 2  (
	set adrs=%link2%
)
if %adrs% == 3  (
	set adrs=%link3%
)
if %adrs% == 4  (
	set adrs=%link4%
)
if %adrs% == 5 (
	set adrs=%link5%
)
if %adrs% == . (
	echo error
	echo,
	timeout 5
	goto a
)
::##################
if %link1% == . ( set flag=1 && goto next )
if %link2% == . ( set flag=2 && goto next )
if %link3% == . ( set flag=3 && goto next )
if %link4% == . ( set flag=4 && goto next )
if %link5% == . ( set flag=5 && goto next )

set flag=0
:next
if %adrs% NEQ 1 (
	if %adrs% NEQ 2 (
		if %adrs% NEQ 3 (
			if %adrs% NEQ 4 (
				if %adrs% NEQ 5 (
					if %adrs% NEQ %link1% (
						if %adrs% NEQ %link2% (
							if %adrs% NEQ %link3% (
								if %adrs% NEQ %link4% (
									if %adrs% NEQ %link5% (
										goto presavelink
									)
								)
							)
						)
					)
				)
			)
		)
	)
)
goto Mode
::##################
:Mode
echo,
set /p nbping="mode ? 1.FAST 2.MID 3.SLOW 4.BIG 5.CUSTOM : " 
if '%nbping%'=='' goto errorping
if %nbping% GEQ 6 goto errorping
if %nbping% == 5 goto pingcustom
if %nbping% == 4 set /a nbping=8 && goto ping
if %nbping% == 3 set /a nbping=4 && goto ping
if %nbping% == 2 set /a nbping=2 && goto ping
if %nbping% == 1 set /a nbping=1 && goto ping
if %nbping% LEQ 0 goto errorping
	goto errorping
)
:pingcustom
echo,
set /p nbping=" Ping number : "
REM ##
:ping
title PingMetter - KSH-Soft - Adrs : %adrs%
echo,
echo Ping adress : %adrs%
echo START...
:ping2
ping %adrs% -n %nbping% >"%temp%\%~n0.ping"
for /f "tokens=3,6,9 delims=, " %%A in ('type "%temp%\%~n0.ping"') do (set "min=%%A"&set "max=%%B"&set "moy=%%C")
set pingresult=!moy:~0,-2!
set /a pingresult+=0
if not "!pingresult!"=="!moy:~0,-2!" (
   set "min=???ms"&set "max=???ms"&set "moy=???ms"
   set/a pingresult=0
)

CALL :ProgressMeter !pingresult!
REM CALL :ProgressMeter 30
REM PING localhost -n 2 >NUL
goto ping2
exit
:ProgressMeter
if %MAD% == 3 goto PgM2
if %MAD% == 1 goto PgM2
SETLOCAL ENABLEDELAYEDEXPANSION
SET ProgressPercent=%1
SET /A NumBars=%ProgressPercent%/2
SET /A NumSpaces=50-%NumBars%+59
rem for 120
SET Meter=

FOR /L %%A IN (%NumBars%,-1,1) DO SET Meter=!Meter!I
FOR /L %%A IN (%NumSpaces%,-1,1) DO SET Meter=!Meter! 

REM TITLE Progress:  %Meter%  %ProgressPercent%%%
echo [%ProgressPercent% ms] %Meter%
ENDLOCAL
REM pause
GOTO :EOF
pause
REM ##

REM ####ERROR###
exit
:PgM2
REM PING MAXXX    218
rem 140
REM 11 10-1 gui (9 ping  digits)
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=2 delims=:" %%a in ('mode con ^| find "Colo"') DO SET v=%%a
FOR /F "tokens=1 delims=." %%m in ('echo !v!') DO SET /A m=%%m
set /A dlp=((!m!-11)*2)-1
REM title !m!
SET ProgressPercent=%1
SET ProgressPercent2=%ProgressPercent%
if %ProgressPercent% GTR %dlp% (
	set /A ProgressPercent2=%dlp%
)
SET /A NumBars=!ProgressPercent2!/2
SET /A NumSpaces=108-%NumBars%+(!m!-120)
rem for 120
SET Meter=

FOR /L %%A IN (%NumBars%,-1,1) DO SET Meter=!Meter!I
FOR /L %%A IN (%NumSpaces%,-1,1) DO SET Meter=!Meter! 

REM TITLE Progress:  %Meter%  %ProgressPercent%%%
if %MCP% == 1 (
	if %ProgressPercent% LEQ %scp1% ( 
		batbox /c 0x08
	)
	if %ProgressPercent% GTR %scp1% ( 
		batbox /c 0x09
	)
	if %ProgressPercent% GTR %scp2% ( 
		batbox /c 0x0B
	)
	if %ProgressPercent% GTR %scp3% ( 
		batbox /c 0x0A
	)
	if %ProgressPercent% GTR %scp4% ( 
		batbox /c 0x0C
	)
	if %ProgressPercent% GTR %scp5% ( 
		batbox /c 0xC0
	)
)
echo [%ProgressPercent% ms] [%Meter%] 
REM echo %NumBars%
batbox /c 0x0F
ENDLOCAL
REM pause
GOTO :EOF
pause
REM ##

REM ####ERROR###
exit
:errorping
cls 
echo error with number ping..
echo,
timeout 10
goto a
exit
REM ################
REM ################
REM ################
REM ################
pause
:presavelink
echo Checking Pinged adress..
Ping %adrs% -n 1 -w 100
call :logo
REM echo errorlevel : !errorlevel!
if %errorlevel% == 1 (
	set internet=0
)
if %errorlevel% == 0 (
	set internet=1
)
REM echo internet : %internet%
if !internet! == 0 (
	echo ERROR
	echo BAD ADRESS
	echo,
	timeout 10
	goto a
)
:savelink
call :logo
if %flag%==1 ( goto y1 )
if %flag%==2 ( goto y2 )
if %flag%==3 ( goto y3 )
if %flag%==4 ( goto y4 )
if %flag%==5 ( goto y5 )
echo,
echo   Adress :%adrs%
echo,
echo   New Link..
echo,
call :linksss
echo,
SET choice=
SET /p choice="  Do you want Save IT ?  (Y/n): "
IF NOT '%choice%'=='' SET choice=%choice:~0,1%
IF '%choice%'=='Y' GOTO yes
IF '%choice%'=='y' GOTO yes
IF '%choice%'=='N' GOTO Mode
IF '%choice%'=='n' GOTO Mode
IF '%choice%'=='' GOTO yes
ECHO "%choice%" is not valid
pause
exit
:yes
if %link1% == . (
	:y1
	echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link1
	echo LINK SAVED IN #1
	goto yes2
)
if %link2% == . (
	:y2
	echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link2
	echo LINK SAVED IN #2
	goto yes2
)
if %link3% == . (
	:y3
	echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link3
	echo LINK SAVED IN #3
	goto yes2
)
if %link4% == . (
	:y4
	echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link4
	echo LINK SAVED IN #4
	goto yes2
)
if %link5% == . (
	:y5
	echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link5
	echo LINK SAVED IN #5
	goto yes2
)
echo,
SET /p choice2=" Do you want Save IT where ?  #?(1,2,3,4 or 5): "
if %choice2% LSS 1 (
	echo error
	goto savelink
)
if %choice2% GTR 5 (
	echo error
	goto savelink
)
if %choice2% == 1 ( echo LINK SAVED IN #1 )
if %choice2% == 1 ( echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link1 && goto yes2 )
if %choice2% == 2 ( echo LINK SAVED IN #2 )
if %choice2% == 2 ( echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link2 && goto yes2 )
if %choice2% == 3 ( echo LINK SAVED IN #3 )
if %choice2% == 3 ( echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link3 && goto yes2 )
if %choice2% == 4 ( echo LINK SAVED IN #4 )
if %choice2% == 4 ( echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link4 && goto yes2 )
if %choice2% == 5 ( echo LINK SAVED IN #5 )
if %choice2% == 5 ( echo %adrs%>%appdata%\KSH-Soft\PingMetter\Link5 && goto yes2 )
:yes2
echo,
timeout 2
goto Mode
goto
exit
:logo
cls
title PingMetter - KSH-Soft - Main V%ver%
echo,
echo,
echo        \ ^| /     
echo        - ^* -                         ^+ SaveLinks
echo         /^|\             V%ver% Update  ^+ SmartSaveLinks    
echo        /\^|/\                         ^+ FastScamCheckAdress       
echo       /  ^|  \      ###############   ^+ ColorPing
echo      /\/\^|/\/\     # PING METTER #   ^+ AdaptDisplay 
echo     /    ^|    \    ###############   ^+ IAAdaptDisplay
echo    -     -     -
echo,
echo,
goto:EOF
:linksss
echo #1 : %link1%
echo #2 : %link2%
echo #3 : %link3%
echo #4 : %link4%
echo #5 : %link5%
goto:EOF
:settings
call :logo
echo :SETUP:
FOR /F "tokens=2 delims=:" %%a in ('mode con ^| find "Colo"') DO SET v=%%a
FOR /F "tokens=1 delims=." %%m in ('echo !v!') DO SET /A m=%%m
echo COL:!m!
echo,
echo Mode enabled : %MCP%
echo 7. Ena\Disa ColorPing   8. Setup ColorPing  9. Enable IAColorPing
echo,
echo Mode enabled : %MAD%
echo 4. Enable\Disable IA-AdaptDispay  
echo,
echo,
SET choix=
SET /p choix=" : "
IF NOT '%choix%'=='' SET choix=%choix:~0,1%
IF '%choix%'=='7' if %MCP% == 1 ( echo 0 >%appdata%\KSH-Soft\PingMetter\MCP && GOTO x ) else ( echo 1 >%appdata%\KSH-Soft\PingMetter\MCP && GOTO x )
IF '%choix%'=='8' GOTO scping
IF '%choix%'=='9' GOTO 
IF '%choix%'=='4' if %MAD% == 1 ( echo 0 >%appdata%\KSH-Soft\PingMetter\MAD && GOTO x ) else ( echo 1 >%appdata%\KSH-Soft\PingMetter\MAD && GOTO x )
IF '%choix%'=='' GOTO settings
ECHO "%choix%" is not valid
pause
exit
:scping
echo,
echo Let's go set 5 point exemple :
echo 1. ping cool(-30)
echo 2. ping hum.(30)
echo 3. ping ho..(50)
echo 4. ping AHHH(80)
echo 5. ping AAAA(+200)
echo,
set /p scp1="ping cool : -"
set /p scp2="ping hum. : "
set /p scp3="ping ho.. : "
set /p scp4="ping AHHH : "
set /p scp5="ping AAAA : +"
pause
exit
:bb
for %%b in ( 
4D5343460000000007040000000000002C000000000000000301010001000000
000000004700000001000100000800000000000000006546B1AE200062617462
6F782E65786500CD6A9177B8030008434BBD555D681C55143E936443FFCC6EB3
196D91E214DA3EF421A06D404B03539368AA1B5D76B70D9442BA9B9DDD99CDEE
CC323B3129BE44362BD4BCF820F86011438A08BE06D452D1BA292DA5A13E14A9
5AA58AC82C2DD887D4F6A1CDF89D3B93660BC1F6C17A77BF3BE77CE7DC73BFFB
B3B34347A64822A2368A90E711A9ECA0A9F4E83605743C77BA83E6D72F6EFF52
8A2D6E4FE9464529DB56DE4E9794D1B4695A8E92D1147BDC540C53E97F33A994
ACACD6FDD4861D2B35E203443149A2D87777532BDC750A4B1B25E9156A87D31E
909126B03A7EB6100572A13F688ACFE7EF13B5368F7B9019B841DB16257AA6E5
3116FB1FB7EE5C31EDE0A9870241EDBEEEE6768CB7E20937BD5F56A9E03FF417
B9DB8BCE93AF77A9545DE82ADCF6E46B5195E6544EFB3B70F6C3711350DBF75E
74EAA2F2BC97FB6A13EDFB703D62E1E93DE05FCDFF7EABF193E779EE667871AF
471545FF4042A30E7AEA6D69245CEBC0FC9EEC62A6DAB7E1E9CFC1A33EBC5E5E
75B8B651849908E162D2DC561EBD846374CFA06B0D2D7442CA2574B9B94116F4
A9602F30FBBD605FE3497B0645EF0B70B9C4CBACEB3892CF87AE74FAF77C8E0D
5D745F7472E255CCDAD8CA8963484C36B1D585750DE2C0258CBB133A8ABAF7E1
866B37D0CFA6647F31BF72C64D6434AE2CC3FA0496FB0BBBE7D8BDC717DF936F
B19A79266EB0065E8FFB1B5BBC86C64708E8C79AC4DF45BA7B96E3593EA7E6D0
12572A70A559C44F9CF7E47B608631C7498EC411F142BC29B3ABFB35BBBA498D
1F9050D8E2F5ECF7CF1E63FC7B21E931318BCFDF045FEDE5008E79112573D55E
8EB7846BDFC0ABCFF4C6E19D583EFB57E49D3FF965D22AB6273E7C583FDDB47F
91BAFB345416F049A2A8E036D5BD1D5FFF88A46A882F61DBCC367ECC3C5BFB39
3CCD3FDCBAD7C3C78F2B24D2DB76566867769FF86E58FB62BF1551691EB8038C
00CA66955E026A80037C0C5C0634A0018CE5D3A3D99235A1978F9BDD998CA871
A66BB55E092F8AABF0E7A3ABDC24EC6BC0074DDCBBB04F46D7D634943CDC9748
75F7C762F4FA40E28D81D89E17844387920389159BE85430FCD4833249DD9A18
36CCAC3521DE7590D105EC0254E02850062681F781CF02D98F9B87DFABE6249D
EC60DACC1635319FE6F45966C52A6A43785F3FCCA4B449E780E3D84666DCD11E
8AF48DDB15CB8E5B15C3312C934725B47436081E34CBE3CE01CE2F6A5A798D71
07CD9C15687904BFB2134BD0BF0CAC9389B6000AB05BF657F46F31EC826D984E
8EAD91BCE68CEAC262B39436CCB49DAFC0D7260D47F06319DDB72A8EED58C5FF
FFBFE249B67F00                                                  
) Do >>t.dat (Echo.For b=1 To len^("%%b"^) Step 2
ECHO WScript.StdOut.Write Chr^(Clng^("&H"^&Mid^("%%b",b,2^)^)^) : Next)
Cscript /b /e:vbs t.dat>batbox.ex_
Del /f /q /a t.dat >nul 2>&1
Expand -r batbox.ex_ >nul 2>&1
Del /f /q /a batbox.ex_ >nul 2>&1
:x
start "" "%~f0"
exit