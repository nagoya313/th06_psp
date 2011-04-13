#ifndef TH06_PSP_ACTOR_HPP_
#define TH06_PSP_ACTOR_HPP_
#include <fstream>
#include <string>
#include <boost/cstdint.hpp>
#include <boost/noncopyable.hpp>
#include <boost/shared_ptr.hpp>

namespace th06_psp { namespace global {
extern std::ofstream *log;
}}

namespace th06_psp {
class actor : private boost::noncopyable {
 public:
  actor() : is_active_(true) {}

  virtual ~actor() {}
  virtual void draw() = 0;
  virtual void move(float x, float y) {}
  virtual void move_to(float x, float y) {}
  virtual void resize(float width, float height) {}
  virtual void set_uv(float u, float v, float width, float height) {}
  virtual void set_color(boost::uint8_t red, boost::uint8_t green, boost::uint8_t blue) {}
  virtual void set_alpha(boost::uint8_t alpha) {}

  virtual float x() const {
    return 0.f;
  }

  virtual float y() const {
    return 0.f;
  }

  virtual bool exist() const {
    return true;
  }

  bool is_active() const {
    return is_active_;
  }

  void set_active(const bool is_active) {
    is_active_ = is_active;
  }

 private:
  bool is_active_;
};

typedef boost::shared_ptr<actor> actor_ptr;

struct actor_element {
  actor_element(const std::string &name, const actor_ptr &ptr) : id(name), element(ptr) {}

  std::string id;
  actor_ptr element;
};

struct actor_id {};
}

#endif
