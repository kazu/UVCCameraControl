CFLAGS= -fmessage-length=0 -pipe -std=c99 -Wno-trigraphs -fpascal-strings -fasm-blocks -Os -mdynamic-no-pic -Wreturn-type -Wunused-variable -I. 

all:
	gcc $(CFLAGS) -bundle -o uvccameracontrol.bundle -framework foundation -framework appkit -framework iokit UVCCameraControl.m
