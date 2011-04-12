#ifndef TH06_PSP_SOUND_HPP_
#define TH06_PSP_SOUND_HPP_
#include <cstring>
#include <string>
#include <boost/flyweight.hpp>
#include <boost/flyweight/key_value.hpp>
#include <boost/functional/hash.hpp>
#include <pspgu.h>
#include <pspiofilemgr.h>
#include "actor.hpp"
#include "vertex.hpp"

namespace th06_psp {
struct se_data {
  explicit se_data(const std::string &key)
      : name_(key), data_(static_cast<unsigned int *>(std::malloc(128 * 128 * sizeof(unsigned int)))) {
    const SceUID fd = sceIoOpen(name_.c_str(), PSP_O_RDONLY, 0777);
    if (fd >= 0) {
      sceIoLseek(fd, 0x80, PSP_SEEK_CUR);
      sceIoRead(fd, data_, 128 * 128 * 4);
      sceIoClose(fd);
    }
  }

  virtual ~image_data() {
    std::free(data_);
  }

  unsigned int *data() const {
    return data_;
  }

 private:
  std::string name_;
  unsigned int *data_;
};

class image : public actor {
 public:
  explicit image(const char * const file_name) 
      : x_(0.f), 
        y_(0.f),
        width_(128.f),
        height_(128.f),
        u_(0.f),
        v_(0.f),
        u_size_(128.f),
        v_size_(128.f),
        data_(file_name) {}

  virtual void draw() {
    sceGuEnable(GU_TEXTURE_2D);
    sceGuTexMode(GU_PSM_8888, 0, 0, GU_FALSE);
    sceGuEnable(GU_BLEND);
    sceGuBlendFunc(GU_ADD, GU_SRC_ALPHA, GU_ONE_MINUS_SRC_ALPHA, 0, 0);
    sceGuTexImage(0, 128, 128, 128, data_.get().data());
    sceGuTexFunc(GU_TFX_REPLACE, GU_TCC_RGBA);
    sceGuTexFilter(GU_LINEAR, GU_LINEAR);
    texture_vertex * const vertex = static_cast<texture_vertex *>(sceGuGetMemory(2 * sizeof(*vertex)));
    vertex[0].u = u_;
    vertex[0].v = v_;
    vertex[0].x = x_;
    vertex[0].y = y_;
    vertex[0].z = 0.f;
    vertex[1].u = u_ + u_size_;
    vertex[1].v = v_ + v_size_;
    vertex[1].x = x_ + width_;
    vertex[1].y = y_ + height_;
    vertex[1].z = 0.f;
    sceGuDrawArray(GU_SPRITES, GU_TEXTURE_32BITF | GU_VERTEX_32BITF | GU_TRANSFORM_2D, 2, 0, vertex);
  }

  virtual void move(const float x, const float y) {
    x_ = x;
    y_ = y;
  }

  virtual void resize(const float width, const float height) {
    width_ = width;
    height_ = height;
  }

  virtual void set_uv(const float u, const float v, const float width, const float height) {
    u_ = u;
    v_ = v;
    u_size_ = width;
    v_size_ = height;
  }

 private:
  float x_;
  float y_;
  float width_;
  float height_;
  float u_;
  float v_;
  float u_size_;
  float v_size_;
  const boost::flyweights::flyweight<boost::flyweights::key_value<std::string, image_data> > data_;
};
}

#endif
