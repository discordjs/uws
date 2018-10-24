CPP_SHARED := -DUSE_LIBUV -std=c++11 -O3 -I ./uWebSockets/src -shared -fPIC ./uWebSockets/src/Extensions.cpp ./uWebSockets/src/Group.cpp ./uWebSockets/src/Networking.cpp ./uWebSockets/src/Hub.cpp ./uWebSockets/src/Node.cpp ./uWebSockets/src/WebSocket.cpp ./uWebSockets/src/HTTPSocket.cpp ./uWebSockets/src/Socket.cpp ./uWebSockets/src/Epoll.cpp src/addon.cpp
CPP_OSX := -stdlib=libc++ -mmacosx-version-min=10.7 -undefined dynamic_lookup

default:
	make targets
	NODE=targets/node-v6.14.4 ABI=48 make `(uname -s)`
	NODE=targets/node-v7.10.1 ABI=51 make `(uname -s)`
	NODE=targets/node-v8.12.0 ABI=57 make `(uname -s)`
	NODE=targets/node-v9.11.2 ABI=59 make `(uname -s)`
	NODE=targets/node-v10.12.0 ABI=64 make `(uname -s)`
	NODE=targets/node-v11.0.0 ABI=67 make `(uname -s)`
	cp README.md dist/README.md
	cp ./uWebSockets/LICENSE dist/LICENSE
	cp -r ./uWebSockets/src dist/
	cp src/addon.cpp dist/src/addon.cpp
	cp src/addon.h dist/src/addon.h
	cp src/http.h dist/src/http.h
	cp src/uws.js dist/uws.js
	for f in dist/*.node; do chmod +x $$f; done
targets:
	mkdir targets
	curl https://nodejs.org/dist/v6.14.4/node-v6.14.4-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v7.10.1/node-v7.10.1-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v8.12.0/node-v8.12.0-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v9.11.2/node-v9.11.2-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v10.12.0/node-v10.12.0-headers.tar.gz | tar xz -C targets
	curl https://nodejs.org/dist/v11.0.0/node-v11.0.0-headers.tar.gz | tar xz -C targets
Linux:
	g++ $(CPP_SHARED) -static-libstdc++ -static-libgcc -I $$NODE/include/node -s -o dist/uws_linux_$$ABI.node
Darwin:
	g++ $(CPP_SHARED) $(CPP_OSX) -I $$NODE/include/node -o dist/uws_darwin_$$ABI.node
.PHONY: clean
clean:
	rm -f dist/README.md
	rm -f dist/LICENSE
	rm -f dist/uws_*.node
	rm -f dist/uws.js
	rm -rf dist/src
	rm -rf targets
