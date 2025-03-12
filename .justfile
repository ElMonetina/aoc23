set windows-powershell := true

ODIN_PATH := `odin root`

build:
    odin run src -out="build/build.exe"

linux-build:
	odin run src -out="build/build"

build-dbg:
    odin run src -debug -out="build/build-dbg.exe"

linux-build-dbg:
	odin run src -debug -out="build/build-dbg"
