#Linux64
make -f Makefile_linux

#linux32
CPPFLAGS=-m32 make -f Makefile_linux

#win
# needs openssl installed for cross environment
CXX=i686-w64-mingw32-g++ CC=i686-w64-mingw32-gcc make -f Makefile_windows

#osx
export PATH=/opt/osxcross/target/bin/:$PATH
export MACOSX_DEPLOYMENT_TARGET=10.9
CXX=o64-clang++ CC=o64-clang++ make -f Makefile_darwin
