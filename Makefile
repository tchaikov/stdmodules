.SUFFIXES: .cppm .pcm

# PATH to LIBCXX STL
#STL_PATH=-isystem /opt/rh/gcc-toolset-12/root/usr/include/c++/12 -I/opt/rh/gcc-toolset-12/root/usr/include/c++/12/x86_64-redhat-linux -I/usr/include
# Default PATH leads to LIBSTDCXX
#STL_PATH=
INTERFACE_OPTION=--precompile -fprebuilt-module-path=.

std_modules := $(wildcard std-*.cppm)

all:  $(std_modules:.cppm=.pcm) libstd.a libstd.compat.a

%.pcm : %.cppm
	clang++ -std=c++20 $(INTERFACE_OPTION) $< -o $@ $(STL_PATH)

%.o : %.pcm
	clang++ -std=c++20 $< -c -o $@

std.pcm : std.cppm $(std_modules:.cppm=.o)
	clang++ -std=c++20 $(INTERFACE_OPTION) $< -o $@ $(STL_PATH)

std.o : std.pcm $(std_modules:.cppm=.pcm)
	clang++ -std=c++20 $< -c -o $@

libstd.a: std.o $(std_modules:.cppm=.o)
	llvm-ar crv $@ $^

std.compat.pcm : std.compat.cppm $(std_compat_modules:.cppm=.pcm)
	clang++ -std=c++20 $(INTERFACE_OPTION) $< -o $@ $(STL_PATH)

libstd.compat.a: std.compat.o std.o $(std_modules:.cppm=.o)
	llvm-ar crv $@ $^

clean:
	rm *.o *.a *.pcm
	cd examples && make clean
