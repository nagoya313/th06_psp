#include "framework.hpp"
#include "back_image.hpp"
#include "box.hpp"
#include "image.hpp"

int main() {
  th06_psp::framework framework;
  while (true) {
    framework.update();
  }
  return 0;
}
