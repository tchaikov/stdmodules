.SUFFIXES: .ccm

CXX := g++
CXXFLAGS=-x c++ -std=c++20 -fmodules-ts

std_modules := $(wildcard std-*.ccm)

all: libstd.a libstd.compat.a

%.o: %.ccm
	$(CXX) $(CXXFLAGS) -c $< -o $@

std.o: std.ccm $(std_modules:.ccm=.o)
	$(CXX) $(CXXFLAGS) -c $< -o $@

libstd.a: std.o $(std_modules:.ccm=.o)
	$(AR) $(ARFLAGS) $@ $^

libstd.compat.a: std.compat.ccm std.a
	$(AR) $(ARFLAGS) $@ $^

clean:
	rm *.o *.a
	cd examples && make clean
