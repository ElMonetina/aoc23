set windows-powershell := true

ODIN_PATH := `odin root`

build:
    odin run src -out="build/build.exe"

build-dbg:
    odin run src -debug -out="build/build-dbg.exe"