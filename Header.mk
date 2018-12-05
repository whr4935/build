ifndef HEADER_MK
HEADER_MK = 1

include $(BUILD_DIR)/Define.mk

CC=gcc
CXX=g++
AR=ar
COMMON_INC := -I$(BASE_DIR)/android -I$(BASE_DIR)/android/include -I$(BASE_DIR)/include -DHAVE_PTHREADS


MODULE  := 
SRC_DIR := 
DEFINE  :=
INCLUDE :=
CFLAGS  := -g -std=c99 -fPIC
CXXFLAGS:= -g -std=gnu++14 -fPIC
LDFLAGS := 
LIBS    := 
EXECUTABLE_LDFLAGS := -Wl,-rpath="out/lib" -rdynamic
EXECUTABLE_LIBS    :=


endif


