prebuild:
  cmake -S hermes -B build_release -G Ninja -DCMAKE_BUILD_TYPE=Release
build:
  cmake --build ./build_release
hermes *FLAGS:
  ./build_release/bin/hermes {{FLAGS}}
shermes *FLAGS:
  ./build_release/bin/shermes {{FLAGS}}
compile_js FILE OUT:
  just shermes -O -emit-c -parse-ts -typed {{FILE}} -o=out/{{OUT}}
compile_c FILE OUT:
  gcc {{FILE}} -DNDEBUG -I./hermes/include -I./build_release/lib/config -o out/{{OUT}} \
  ./build_release/lib/libhermesvm_a.a \
  ./build_release/lib/VM/libhermesVMRuntime.a \
  ./build_release/jsi/libjsi.a \
  ./build_release/lib/Platform/Unicode/libhermesPlatformUnicode.a \
  ./build_release/external/boost/boost_1_86_0/libs/context/libboost_context.a \
  ./build_release/lib/ConsoleHost/libhermesConsoleHost.a \
  ./build_release/tools/shermes/libshermes_console_a.a \
  -framework CoreFoundation -lc++
js_to_c FILE OUT:
  just compile_js {{FILE}} {{OUT}}.c && just compile_c out/{{OUT}}.c {{OUT}}