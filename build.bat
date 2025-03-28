mkdir libs
mkdir libs\debug
mkdir libs\debug\windows
mkdir libs\release
mkdir libs\release\windows

cd LuaJIT\src
call msvcbuild.bat static
cd ..\..

move LuaJIT\src\lua51.dll libs\release\windows
move LuaJIT\src\lua51.lib libs\release\windows
move LuaJIT\src\lua51.exp libs\release\windows
move LuaJIT\src\luajit.lib libs\release\windows
move LuaJIT\src\luajit.pdb libs\release\windows