#ifndef TH06_PSP_BOX_HPP_
#define TH06_PSP_BOX_HPP_
#include <pspgu.h>
#include "actor.hpp"
#include "vertex.hpp"

namespace th06_psp {
class box : public actor {
 public:
  box(const float x, const float y, const float width, const float height) 
      : x_(x), y_(y), width_(width), height_(height), color_(0xFFFFFF), alpha_(0xFF) {}

  virtual void draw() {
    sceGuDisable(GU_TEXTURE_2D);
    sceGuEnable(GU_BLEND);
    sceGuBlendFunc(GU_ADD, GU_SRC_ALPHA, GU_ONE_MINUS_SRC_ALPHA, 0, 0);
    shape_vertex * const vertex = static_cast<shape_vertex *>(sceGuGetMemory(2 * sizeof(*vertex)));
    //alpha_ = 0x80;
    vertex[0].color = color_ | static_cast<boost::uint32_t>(alpha_) << 24;
    vertex[0].x = x_;
    vertex[0].y = y_;
    vertex[0].z = 0.f;
    vertex[1].color = color_ | static_cast<boost::uint32_t>(alpha_) << 24;
    vertex[1].x = x_ + width_;
    vertex[1].y = y_ + height_;
    vertex[1].z = 0.f;
    sceGuDrawArray(GU_SPRITES, GU_VERTEX_32BITF | GU_COLOR_8888 | GU_TRANSFORM_2D, 2, 0, vertex);
  }

  virtual void move(const float x, const float y) {
    x_ = x;
    y_ = y;
  }

  virtual void resize(const float width, const float height) {
    width_ = width;
    height_ = height;
  }
  
  virtual void set_color(const boost::uint8_t red, const boost::uint8_t green, const boost::uint8_t blue) {
    color_ = blue << 16 | green << 8 | red << 0;
  }

  virtual void set_alpha(const boost::uint8_t alpha) {
    alpha_ = alpha;
  }

 private:
  float x_;
  float y_;
  float width_;
  float height_;
  boost::uint32_t color_;
  boost::uint8_t alpha_;
};
}

#endif
