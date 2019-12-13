CC = gcc
OO = g++
DEFS = 


ARCH:=$(shell uname -m)
BIT32:=i686
BIT64:=x86_64

ifeq ($(ARCH),$(BIT64))
	TARGET =  WhiteBoxTool_x64
else
	TARGET =  WhiteBoxTool_x86
endif

CFLAGS   = -fPIC -static -Wl,-whole-archive -lm -Wl,-whole-archive -lstdc++ -Wl,-whole-archive -lc -Wl,-no-whole-archive -Wl,-O1 
CCFLAGS  = -pipe -fvisibility=hidden -O2 -Wall -W -fPIC $(DEFS)
CXXFLAGS = 
OBJDIR = objs


INCLUDE += -I ./ -I ./sm4

CPPLIST = $(wildcard *.cpp ./*.cpp)    						# get cpp file list
CLIST = $(wildcard *.c ./*.c)								# get c file list
CPPNAME = $(patsubst %.c, %, $(CLIST)) 						# get corresponding target file
NOBJS=$(notdir $(OBJS))
OBJECTDIR=objs

OBJ_DIR = objs
#OBJS = $(addprefix $(OBJ_DIR)/,$(patsubst %.c,%.o,$(notdir $(CLIST))))
#OBJS = $(patsubst %.c,%.o, $(notdir $(CLIST)))
OBJS = $(patsubst %.c,%.o, $(CLIST))
#DIRS = $(shell find $(SRC_PATH) -maxdepth 3 -type d)

DIRS =  ./sm4 .
SRCS_C += $(foreach dir, $(DIRS), $(wildcard $(dir)/*.c))
SRCS_CPP += $(foreach dir, $(DIRS), $(wildcard $(dir)/*.cpp))
OBJS_C = $(patsubst %.c, %.o, $(SRCS_C))
OBJS_CPP = $(patsubst %.cpp, %.o, $(SRCS_CPP))

VPATH = core sm4 hxyh
OBJECTS = $(OBJS_C)
OBJECTS += $(OBJS_CPP)

all : $(OBJECTS) 
	$(OO) $(CFLAGS) -o $(TARGET) $(OBJECTDIR)/*.o $(LIBS)
	
$(OBJECTDIR) :
	mkdir $(OBJECTDIR)

%.o : %.c $(OBJECTDIR) 
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $(OBJECTDIR)/$(notdir $@)

%.o : %.cpp $(OBJECTDIR) 
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $(OBJECTDIR)/$(notdir $@)

clean:
	rm -f $(TARGET)
	rm -f $(OBJECTDIR)/*.o $(OBJECTDIR)/core/*.o

info:$(CLIST)
	@echo $(basename $(CLIST))
	@echo $(OBJS)

ls: 
	@echo $(OBJS_C)
