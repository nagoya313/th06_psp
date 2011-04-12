#ifndef TH06_PSP_CONTROLLER_HPP_
#define TH06_PSP_CONTROLLER_HPP_
#include <pspctrl.h>

namespace psp { namespace input {
enum key_code{
  kCircle = PSP_CTRL_CIRCLE,
  kTriangle = PSP_CTRL_TRIANGLE,
  kCross = PSP_CTRL_CROSS,
  kSquare = PSP_CTRL_SQUARE,
  kUp = PSP_CTRL_UP,
  kDown = PSP_CTRL_DOWN,
  kLeft = PSP_CTRL_LEFT,
  kRight = PSP_CTRL_RIGHT,
  kStart = PSP_CTRL_START,
  kSelect = PSP_CTRL_SELECT,
  kLeftTriger = PSP_CTRL_LTRIGGER,
  kRightTriger = PSP_CTRL_RTRIGGER
};

void init_controller();
void pool_controller();
bool down(key_code code);
bool triger(key_code code);
int analog_x();
int analog_y();
}}

#endif
