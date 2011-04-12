#ifndef TH06_PSP_VERTEX_HPP_
#define TH06_PSP_VERTEX_HPP_
#include <boost/cstdint.hpp>

namespace th06_psp {
struct texture_vertex {
  float u;
  float v;
  float x;
  float y;
  float z;
};

struct bright_texture_vertex {
  float u;
  float v;
  boost::uint32_t color;
  float x;
  float y;
  float z;
};

struct shape_vertex {
  boost::uint32_t color;
  float x;
  float y;
  float z;
};
}

#endif
