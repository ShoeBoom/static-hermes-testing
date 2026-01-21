prebuild:
  cmake -S hermes -B build_release -G Ninja -DCMAKE_BUILD_TYPE=Release
build:
  cmake --build ./build_release
hermes *FLAGS:
  ./build_release/bin/hermes {{FLAGS}}
shermes *FLAGS:
  ./build_release/bin/shermes {{FLAGS}}
compile_js FILE:
  just shermes -O -emit-c {{FILE}}
compile_c FILE OUT:
  gcc {{FILE}} -DNDEBUG -I./hermes/include -I./build_release/lib/config -o {{OUT}} \
  ./build_release/lib/libhermesvm_a.a \
  ./build_release/lib/VM/libhermesVMRuntime.a \
  ./build_release/jsi/libjsi.a \
  ./build_release/lib/Platform/Unicode/libhermesPlatformUnicode.a \
  ./build_release/external/boost/boost_1_86_0/libs/context/libboost_context.a \
  ./build_release/lib/ConsoleHost/libhermesConsoleHost.a \
  ./build_release/tools/shermes/libshermes_console_a.a \
  -framework CoreFoundation -lc++