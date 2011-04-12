#include "application.hpp"
#include <pspkernel.h>
PSP_MODULE_INFO("th06_psp", PSP_MODULE_USER, 1, 1);
PSP_MAIN_THREAD_ATTR(THREAD_ATTR_USER | THREAD_ATTR_VFPU);

namespace {
int exit_callback(int, int, void *) {
  sceKernelExitGame();
	return 0;
}

int callback_thread(SceSize, void *) {
  const int cb_id = sceKernelCreateCallback("Exit Callback", &exit_callback, NULL);
  if (cb_id > 0) {
    sceKernelRegisterExitCallback(cb_id);
  }
	sceKernelSleepThreadCB();
  return 0;
}

int setup_callbacks() {
  const int thread_id = sceKernelCreateThread("update_thread", &callback_thread, 0x11, 0xFA0, 0, NULL);
  if (thread_id > 0) {
    sceKernelStartThread(thread_id, 0, NULL);
  }
  return thread_id;
}
}

namespace psp { namespace application {
initializer::initializer() {
  setup_callbacks();
}

initializer::~initializer() {
  sceKernelExitGame();
}
}}
