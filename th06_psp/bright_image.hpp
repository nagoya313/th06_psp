#ifndef TH06_PSP_BRIGHT_IMAGE_HPP_
#define TH06_PSP_BTIGHT_IMAGE_HPP_
#include <string>
#include <boost/flyweight.hpp>
#include <boost/flyweight/key_value.hpp>
#include <pspgu.h>
#include "actor.hpp"
#include "image_data.hpp"
#include "vertex.hpp"

namespace th06_psp {
class bright_image : public actor {
 public:
  explicit bright_image(const char * const file_name) 
      : x_(0.f), 
        y_(0.f),
        width_(128.f),
        height_(128.f),
        u_(0.f),
        v_(0.f),
        u_size_(128.f),
        v_size_(128.f),
        color_(0xFFFFFF),
        alpha_(0xFF),
        data_(file_name) {}

  virtual void draw() {
    sceGuEnable(GU_TEXTURE_2D);
    sceGuTexMode(GU_PSM_8888, 0, 0, GU_FALSE);
    sceGuEnable(GU_BLEND);
    sceGuBlendFunc(GU_ADD, GU_SRC_ALPHA, GU_ONE_MINUS_SRC_ALPHA, 0, 0);
    sceGuTexImage(0, 256, 256, 256, data_.get().data());
    sceGuTexFunc(GU_TFX_MODULATE, GU_TCC_RGBA);
    sceGuTexFilter(GU_LINEAR, GU_LINEAR);
    bright_texture_vertex * const vertex = static_cast<bright_texture_vertex *>(sceGuGetMemory(2 * sizeof(*vertex)));
    vertex[0].u = u_;
    vertex[0].v = v_;
    vertex[0].color = color_ | static_cast<boost::uint32_t>(alpha_) << 24;
    vertex[0].x = x_;
    vertex[0].y = y_;
    vertex[0].z = 0.f;
    vertex[1].u = u_ + u_size_;
    vertex[1].v = v_ + v_size_;
    vertex[1].color = color_ | static_cast<boost::uint32_t>(alpha_) << 24;
    vertex[1].x = x_ + width_;
    vertex[1].y = y_ + height_;
    vertex[1].z = 0.f;
    sceGuDrawArray(GU_SPRITES, GU_TEXTURE_32BITF | GU_COLOR_8888 | GU_VERTEX_32BITF | GU_TRANSFORM_2D, 2, 0, vertex);
  }

  virtual void move_to(const float x, const float y) {
    x_ = x;
    y_ = y;
  }

  virtual void move(const float x, const float y) {
    x_ += x;
    y_ += y;
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

  virtual void set_color(const boost::uint8_t red, const boost::uint8_t green, const boost::uint8_t blue) {
    color_ = blue << 16 | green << 8 | red;
  }

  virtual void set_alpha(const boost::uint8_t alpha) {
    alpha_ = alpha;
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
  boost::uint32_t color_;
  boost::uint8_t alpha_;
  const boost::flyweights::flyweight<boost::flyweights::key_value<std::string, image_data> > data_;
};
}

#endif
