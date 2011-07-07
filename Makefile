# gsn makefile
# this is really all we need because D compiles so fast
# Create `Makefile-extras' if you want customization. If present, that file
# will be included after all variable definitions. It'll be ignored by git.

OBJDIR  := ./obj/
SRCDIR  := ./src/
BINDIR  := ./bin/
EXE     := ./bin/gsn
SRC     := $(shell find $(SRCDIR) -name "*.d")

DFLAGS  := -gc

LDDIRS  := -L-L/usr/local/lib
LDALLEG := -L-ldallegro5 -L-lallegro \
           -L-lallegro_primitives \
           -L-lallegro_image
LDOTHER := -L-lrt

-include Makefile-extras

###############################################################################

.PHONY: all run clean

all: $(EXE)

run: all
	$(EXE)

$(EXE): $(SRC)
	@test -d $(OBJDIR) || mkdir $(OBJDIR)
	@test -d $(BINDIR) || mkdir $(BINDIR)
	dmd $(DFLAGS) $(SRC) $(LDDIRS) $(LDALLEG) $(LDOTHER) \
	    -od$(OBJDIR) -of$(EXE)

clean:
	rm -f $(shell find $(OBJDIR) -name "*.o")
	rm -f $(EXE)

