# Make template for small/mid C++ Projects
v0.9

## Use
1) Open terminal in VSCode or CMD
2) Try make --version, if it fails go to ad 3)
3) Try Mingw32-make --version, if it fails, check if you have gcc compiler/make tools installed or in environmental variables
4) OPTIONAL - Install MinGW32
5) Use command from 2) or 3) without argument to build and run your app

## Options
- make "builds and runs your app"
- make build "builds your app"
- make execute "runs your app if it is build"
- make clean "deletes every build file"

## Arguments
- DEBUG "If true builds without optimisation and with debug option, default ON"
- ENABLE_WARNINGS "If true builds with Warning detection, default ON"
- WARNINGS_AS_ERRORS "If true all warnings are errors, wont build, default OFF"
