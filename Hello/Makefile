NVCC=nvcc

SOURCES=$(wildcard *.cu)
OBJECTS=$(SOURCES:.cu=.o)
EXECUTABLES=$(SOURCES:.cu=)

clean:
	rm -f $(OBJECTS) $(EXECUTABLES)

all: $(EXECUTABLES)

%: %.cu
	$(NVCC) -o $@ $<

.PHONY: all clean
