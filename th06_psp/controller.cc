#include "controller.hpp"
#include <pspctrl.h>

namespace {
SceCtrlData pad;
unsigned int before;
}

namespace psp { namespace input {
void init_controller() {
  sceCtrlSetSamplingCycle(0);
  sceCtrlSetSamplingMode(PSP_CTRL_MODE_ANALOG);
}

void pool_controller() {
  before = pad.Buttons;
  sceCtrlReadBufferPositive(&pad, 1);
}

bool down(const key_code code) {
  return pad.Buttons & code;
}

bool triger(const key_code code) {
  return pad.Buttons & code && !(before & code);
}

int analog_x() {
  return pad.Lx;
}

int analog_y() {
  return pad.Ly;
}
}}
