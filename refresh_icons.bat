@echo off
taskkill /f /im explorer.exe
attrib -h -r -s "%localappdata%\IconCache.db"
del /q "%localappdata%\IconCache.db"
attrib -h -r -s "%localappdata%\Microsoft\Windows\Explorer\iconcache*.db"
del /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*.db"

:: Delete Thumbnails Cache
attrib -h -r -s "%localappdata%\Microsoft\Windows\Explorer\thumbcache*.db"
del /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*.db"

start explorer.exe