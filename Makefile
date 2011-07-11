# gsn makefile
# this is really all we need because D compiles so fast
# Create `Makefile-extras' if you want customization. If present, that file
# will be included after all variable definitions. It'll be ignored by git.

OBJDIR  := ./obj/
SRCDIR  := ./src/
BINDIR  := ./bin/
DOBJ    := $(OBJDIR)dall.o
COBJ    := $(OBJDIR)call.o
EXE     := ./bin/gsn
DSRC     := $(shell find $(SRCDIR) -name "*.d")
CSRC     := $(shell find $(SRCDIR) -name "*.c")

DFLAGS  := -gc -debug
CFLAGS  := --std=gnu99 -Wall -g

LDDIRS  := -L/usr/local/lib
LDALLEG := -ldallegro5 -lallegro \
           -lallegro_primitives \
           -lallegro_image
LDDLANG := -lrt -lphobos2 -ldallegro5
LDOTHER := -g

-include Makefile-extras

###############################################################################

.PHONY: all run clean

all: $(EXE)

run: all
	$(EXE)

$(EXE): $(DOBJ) $(COBJ)
	@test -d $(BINDIR) || mkdir $(BINDIR)
	gcc -o $(EXE) $(DOBJ) $(COBJ) $(LDDIRS) $(LDALLEG) $(LDDLANG) $(LDOTHER)

$(DOBJ): $(DSRC)
	@test -d $(OBJDIR) || mkdir $(OBJDIR)
	dmd -c $(DFLAGS) $(DSRC) -od$(OBJDIR) -of$(DOBJ)

$(COBJ): $(CSRC)
	@test -d $(OBJDIR) || mkdir $(OBJDIR)
	gcc -c $(CFLAGS) $(CSRC) -o $(COBJ)

clean:
	rm -f $(shell find $(OBJDIR) -name "*.o")
	rm -f $(EXE)

