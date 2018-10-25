call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

if not exist targets (
mkdir targets
curl https://nodejs.org/dist/v6.14.4/node-v6.14.4-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v6.14.4/win-x64/node.lib > targets/node-v6.14.4/node.lib
curl https://nodejs.org/dist/v7.10.1/node-v7.10.1-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v7.10.1/win-x64/node.lib > targets/node-v7.10.1/node.lib
curl https://nodejs.org/dist/v8.12.0/node-v8.12.0-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v8.12.0/win-x64/node.lib > targets/node-v8.12.0/node.lib
curl https://nodejs.org/dist/v9.11.2/node-v9.11.2-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v9.11.2/win-x64/node.lib > targets/node-v9.11.2/node.lib
curl https://nodejs.org/dist/v10.12.0/node-v10.12.0-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v10.12.0/win-x64/node.lib > targets/node-v10.12.0/node.lib
curl https://nodejs.org/dist/v11.0.0/node-v11.0.0-headers.tar.gz | tar xz -C targets
curl https://nodejs.org/dist/v11.0.0/win-x64/node.lib > targets/node-v11.0.0/node.lib
)

cp README.md dist/README.md
cp ./uWebSockets/LICENSE dist/LICENSE
cp -r ./uWebSockets/src dist/
cp src/addon.cpp dist/src/addon.cpp
cp src/addon.h dist/src/addon.h
cp src/http.h dist/src/http.h
cp src/uws.js dist/uws.js

cl /I targets/node-v6.14.4/include/node /EHsc /Ox /LD /Fedist/uws_win32_48.node dist/src/*.cpp targets/node-v6.14.4/node.lib
cl /I targets/node-v7.10.1/include/node /EHsc /Ox /LD /Fedist/uws_win32_51.node dist/src/*.cpp targets/node-v7.10.1/node.lib
cl /I targets/node-v8.12.0/include/node /EHsc /Ox /LD /Fedist/uws_win32_57.node dist/src/*.cpp targets/node-v8.12.0/node.lib
cl /I targets/node-v9.11.2/include/node /EHsc /Ox /LD /Fedist/uws_win32_59.node dist/src/*.cpp targets/node-v9.11.2/node.lib
cl /I targets/node-v10.12.0/include/node /EHsc /Ox /LD /Fedist/uws_win32_64.node dist/src/*.cpp targets/node-v10.12.0/node.lib
cl /I targets/node-v11.0.0/include/node /EHsc /Ox /LD /Fedist/uws_win32_67.node dist/src/*.cpp targets/node-v11.0.0/node.lib

rm *.obj
rm dist/*.exp
rm dist/*.lib
rm -rf targets
