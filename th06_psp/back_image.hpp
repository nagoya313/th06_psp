#ifndef TH06_PSP_BACK_IMAGE_HPP_
#define TH06_PSP_BACK_IMAGE_HPP_
#include <cstring>
#include <pspgu.h>
#include <pspiofilemgr.h>
#include "actor.hpp"
#include "vertex.hpp"

namespace th06_psp {
class back_image : public actor {
 public:
  explicit back_image(const char * const file_name) 
      : back_image_pixel_(static_cast<unsigned int *>(std::malloc(480 * 272 * sizeof(unsigned int)))), name_(file_name) {
    const SceUID fd = sceIoOpen(file_name, PSP_O_RDONLY, 0777);
    if (fd >= 0) {
      sceIoLseek(fd, 0x80, PSP_SEEK_CUR);
      if (sceIoRead(fd, back_image_pixel_, 480 * 272 * 4) < 0) {
        *global::log << "file read error" << std::endl;
      }
      sceIoClose(fd);
    } else {
      *global::log << "file loading error" << std::endl;
    }
    *global::log << "file_name: " << file_name << ", address: " << back_image_pixel_ << std::endl;
  }

  virtual ~back_image() {
    *global::log << "dtr file_name: " << name_ << ", address: " << back_image_pixel_ << std::endl;
    std::free(back_image_pixel_);
  }

  virtual void draw() {
    sceGuEnable(GU_TEXTURE_2D);
    sceGuTexMode(GU_PSM_8888, 0, 0, GU_FALSE);
    sceGuTexImage(0, 512, 512, 480, back_image_pixel_);
    sceGuDisable(GU_BLEND);
    sceGuTexFunc(GU_TFX_REPLACE, GU_TCC_RGB);
    sceGuTexFilter(GU_NEAREST, GU_NEAREST);
    texture_vertex * const vertex = static_cast<texture_vertex *>(sceGuGetMemory(2 * sizeof(*vertex)));
    vertex[0].u = vertex[0].v = vertex[0].x = vertex[0].y = vertex[0].z = vertex[1].z = 0.f;
    vertex[1].u = vertex[1].x = 480.f;
    vertex[1].v = vertex[1].y = 272.f;
    sceGuDrawArray(GU_SPRITES, GU_TEXTURE_32BITF | GU_VERTEX_32BITF | GU_TRANSFORM_2D, 2, 0, vertex);
  }

 private:
  unsigned int *back_image_pixel_;
  std::string name_;
};
}

#endif
