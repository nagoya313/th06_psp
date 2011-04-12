#ifndef TH06_PSP_GRAPHIC_HPP_
#define TH06_PSP_GRAPHIC_HPP_
#include <boost/cstdint.hpp>
#include <boost/noncopyable.hpp>
#include <boost/shared_ptr.hpp>

namespace psp { namespace font {
struct initializer : private boost::noncopyable {
  initializer();
  ~initializer();
};

void set_font(float size, boost::uint32_t color);
void draw_text(float x, float y, const char *text);
}}

namespace psp { namespace graphic {
struct initializer : private boost::noncopyable {
  initializer();
  ~initializer();

 private:
  font::initializer font_initializer_;
};

struct scoped_render : private boost::noncopyable {
  scoped_render();
  ~scoped_render();
};

void clear_screen();
void draw_int(int x);
}}

#endif
