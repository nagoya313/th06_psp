#include "graphic.hpp"
#include <pspdisplay.h>
#include <pspgu.h>
#include <pspiofilemgr.h>
#include <intraFont.h>
//#include <boost/lexical_cast.hpp>
#include "vertex.hpp"

namespace {
unsigned int __attribute__((aligned(16))) display_list[262144];
const int kBufferWidth = 512;
const int kScrWidth = 480;
const int kScrHeight = 272;
const int kPixelSize = 4;
const int kFrameSize = kBufferWidth * kScrHeight * kPixelSize;
intraFont* jpn0;
}

namespace psp { namespace font {
initializer::initializer() {
  intraFontInit();
  jpn0 = intraFontLoad("jpn0.pgf", INTRAFONT_STRING_UTF8);
}

initializer::~initializer() {
  intraFontUnload(jpn0);
  intraFontShutdown();
}

void set_font(const float size, const boost::uint32_t color) {
  intraFontSetStyle(jpn0, size, color, 0x00000000, 0);
}

void draw_text(const float x, const float y, const char * const text) {
  sceGuEnable(GU_TEXTURE_2D);
  sceGuTexMode(GU_PSM_8888, 0, 0, GU_FALSE);
  sceGuEnable(GU_BLEND);
  sceGuBlendFunc(GU_ADD, GU_SRC_ALPHA, GU_ONE_MINUS_SRC_ALPHA, 0, 0);
  sceGuTexFunc(GU_TFX_MODULATE, GU_TCC_RGBA);
  intraFontPrint(jpn0, x, y, text);
  sceGuDisable(GU_DEPTH_TEST);
}
}}

namespace psp { namespace graphic {
initializer::initializer() : font_initializer_() {
  sceGuInit();
  sceGuStart(GU_DIRECT, display_list);
  sceGuDrawBuffer(GU_PSM_8888, NULL, kBufferWidth);
  sceGuDispBuffer(kScrWidth, kScrHeight, reinterpret_cast<void *>(kFrameSize), kBufferWidth);
  sceGuOffset(2048 - kScrWidth / 2, 2048 - kScrHeight / 2);
  sceGuViewport(2048, 2048, kScrWidth, kScrHeight);
  sceGuScissor(0, 0, kScrWidth, kScrHeight);
  sceGuEnable(GU_SCISSOR_TEST);
  sceGuClearColor(0xFF000000);
  sceGuClear(GU_COLOR_BUFFER_BIT | GU_DEPTH_BUFFER_BIT);
  sceGuDisable(GU_DEPTH_TEST);
  sceGuFinish();
  sceGuSync(0, GU_SYNC_FINISH);
  sceDisplayWaitVblankStart();
  sceGuDisplay(GU_TRUE);
}

initializer::~initializer() {
  sceGuTerm();
}

scoped_render::scoped_render() {
  sceGuStart(GU_DIRECT, display_list);
}

scoped_render::~scoped_render() {
  sceGuFinish();
  sceGuSync(0, GU_SYNC_FINISH);
  sceDisplayWaitVblankStart();
  sceGuSwapBuffers();
}

void clear_screen() {
	sceGuClear(GU_COLOR_BUFFER_BIT);
}
}}
