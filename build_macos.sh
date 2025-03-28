mkdir -p libs/debug/linux
mkdir -p libs/release/linux

cd LuaJIT/src
make
cd ../..

mv LuaJIT/src/libluajit.a libs/release/linux
mv LuaJIT/src/libluajit.dylib libs/release/linux