#ifndef TH06_PSP_TEXT_HPP_
#define TH06_PSP_TEXT_HPP_
#include <string>
#include "actor.hpp"
#include "graphic.hpp"
#include "vertex.hpp"

namespace th06_psp {
class text : public actor {
 public:
  text(const float x, const float y, const std::string &str) 
      : size_(1.f), x_(x), y_(y), color_(0xFFFFFF), alpha_(0xFF), text_(str) {}

  virtual void draw() {
    psp::font::set_font(size_, color_ | static_cast<boost::uint32_t>(alpha_) << 24);
    psp::font::draw_text(x_, y_, text_.c_str());
  }

  virtual void move(const float x, const float y) {
    x_ = x;
    y_ = y;
  }

  virtual void resize(const float width, const float height) {
    size_ = width;
  }
  
  virtual void set_color(const boost::uint8_t red, const boost::uint8_t green, const boost::uint8_t blue) {
    color_ = blue << 16 | green << 8 | red;
  }

  virtual void set_alpha(const boost::uint8_t alpha) {
    alpha_ = alpha;
  }

 private:
  float size_;
  float x_;
  float y_;
  boost::uint32_t color_;
  boost::uint8_t alpha_;
  std::string text_;
};
}

#endif
