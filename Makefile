## VARIABLES
DEBUG ?= 1
ENABLE_WARNINGS ?= 1
WARNINGS_AS_ERRORS ?= 0
DETECTED_OS = 

ifeq ($(OS),Windows_NT)     # is Windows_NT on XP, 2000, 7, Vista, 10...
    DETECTED_OS := Windows
else
    DETECTED_OS := $(shell uname)  # same as "uname -s"
endif

INCLUDE_DIR = include
SOURCE_DIR = src
BUILD_DIR = build

CXX = g++
CXX_STANDARD = c++17

ifeq ($(ENABLE_WARNINGS), 1)
CXX_WARNINGS = -Wall -Wextra -Wpedantic
else
CXX_WARNINGS =
endif

ifeq ($(WARNINGS_AS_ERRORS), 1)
CXX_WARNINGS += -Werror
endif

CXXFLAGS = $(CXX_WARNINGS) -std=$(CXX_STANDARD)
CPPFLAGS = -I $(INCLUDE_DIR)
LDFLAGS = 

ifeq ($(DEBUG), 1)
CXXFLAGS += -g -O0
	ifeq ($(DETECTED_OS), Windows)
	EXECUTABLE_NAME = mainDebug.exe
	else
	EXECUTABLE_NAME = mainDebug
	endif
else
CXXFLAGS += -O3
	ifeq ($(DETECTED_OS), Windows)
	EXECUTABLE_NAME = main.exe
	else
	EXECUTABLE_NAME = main
	endif
endif

COMPILER_CALL = $(CXX) $(CXXFLAGS) $(CPPFLAGS)

CXX_SOURCES = $(wildcard $(SOURCE_DIR)/*.cpp $(SOURCE_DIR)/*.cc)
CXX_OBJECTS = $(wildcard $(SOURCE_DIR)/%.cpp $(SOURCE_DIR)/*.cc, $(BUILD_DIR)/%.o, $(CXX_SOURCES))

## TARGETS
all: create build execute

create:
ifeq ($(DETECTED_OS),Windows)
	@if not exist "build" mkdir build
else
	@mkdir -p build
endif

build: $(CXX_OBJECTS)
	$(COMPILER_CALL) $(CXX_OBJECTS) -o $(BUILD_DIR)/$(EXECUTABLE_NAME)

execute:
	./$(BUILD_DIR)/$(EXECUTABLE_NAME)

clean:
	rm -f $(BUILD_DIR)/*.o
	rm -f $(BUILD_DIR)/$(EXECUTABLE_NAME)

## PATTERNS
# $@: name of the file target
# $<: name of the first dependency
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp 
	$(COMPILER_CALL) -c $< -o $@

## PHONY
.PHONY: all build create execute clean