TARGET = th06_psp

OBJS = th06_psp/main.o th06_psp/application.o th06_psp/graphic.o th06_psp/audio.o th06_psp/controller.o th06_psp/glue.o

PSPSDK = C:/PSPSDK/psp/sdk

INCDIR = C:/lib/boost_1_46_1
CFLAGS = -O2 -G0 -Wall
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)
  
LIBDIR =
LDFLAGS =
LIBS = -lintraFont -llua -lpspgu -lpspaudiolib -lpspaudio -lm -lstdc++

EXTRA_TARGETS = EBOOT.PBP

PSP_EBOOT_TITLE = th06_psp
PSP_EBOOT_ICON  = icon.png
PSP_EBOOT_PIC1  = pic.png

include $(PSPSDK)/lib/build.mak