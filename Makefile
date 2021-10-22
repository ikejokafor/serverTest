#
# 'make depend' uses makedepend to automatically generate dependencies 
#			   (dependencies are added to end of Makefile)
# 'make'		build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#

# get current working directory name and absolute directory path
CWD = $(notdir $(shell pwd))
CWD_A = $(shell pwd)


# define the C compiler to use
CC = g++


# define any compile-time flags
# C++ compiler flags (-g -O0 -O1 -O2 -O3 -Wall -std=c++14 -std=c++11 -fPIC -fexceptions)
CFLAGS = -Wall -std=c++1y -g -fPIC -fexceptions


# define any directories containing header files other than /usr/include
#
INCLUDES =  -I/usr/include/ \
			-I/usr/local/include/ \
			-I./inc/ \
			-I$(CWD_A)/../network/inc/ \


# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS =	-L/usr/lib/ \
			-L/usr/local/lib/ \
			-L$(CWD_A)/../network/build/debug/ \


# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
LIBS =  -lm \
		-lnetwork


# define the C source files
SRCS := $(wildcard ./src/*.cpp)
# $(info $(SRC))


# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#		 For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
OBJS = $(SRCS:.cpp=.o)


# define the executable file 
TARGET = build/debug/$(CWD)


#
# The following part of the makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#
.PHONY: depend clean


default: $(TARGET)


$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(TARGET) $(OBJS) $(LFLAGS) $(LIBS)


# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)
.cpp.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@


clean:
	$(RM) *.o *~ $(TARGET)


depend: $(SRCS)
	makedepend $(INCLUDES) $^

# DO NOT DELETE THIS LINE -- make depend needs it
