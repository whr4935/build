ifndef HEADER_MK
HEADER_MK = 1

include $(BUILD_DIR)/Define.mk

CC=gcc
CXX=g++
AR=ar
COMMON_INC := -I$(BASE_DIR)/android -I$(BASE_DIR)/android/include -I$(BASE_DIR)/include -DHAVE_PTHREADS

Q:=@
ifneq ($(showcommands), )
Q:=
endif


MODULE  := 
SRC_DIR := 
DEFINE  :=
INCLUDE :=
CFLAGS  := -g -std=gnu99 -fPIC -D_GNU_SOURCE
CXXFLAGS:= -g -std=gnu++14 -fPIC
LDFLAGS := -L$(LIBS_DIR)
LIBS    := 
EXECUTABLE_LDFLAGS := -Wl,-rpath="out/lib" -rdynamic
EXECUTABLE_LIBS    :=


endif


