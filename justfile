prebuild:
  cmake -S hermes -B build_release -G Ninja -DCMAKE_BUILD_TYPE=Release
build:
  cmake --build ./build_release
hermes *FLAGS:
  ./build_release/bin/hermes {{FLAGS}}
shermes *FLAGS:
  ./build_release/bin/shermes {{FLAGS}}