@echo off
set configPath=%cd%
taskkill /im redis* /f
taskkill /im nginx* /f