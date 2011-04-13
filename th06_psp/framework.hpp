#ifndef TH06_PSP_FRAMEWORK_HPP_
#define TH06_PSP_FRAMEWORK_HPP_
#include <fstream>
#include <string>
#include <vector>
#include <boost/foreach.hpp>
#include <boost/noncopyable.hpp>
#include <boost/range/algorithm_ext.hpp>
#include <boost/shared_ptr.hpp>
#include <lua.hpp>
#include "actor.hpp"
#include "application.hpp"
#include "audio.hpp"
#include "back_image.hpp"
#include "controller.hpp"
#include "fwd.hpp"
#include "glue.hpp"
#include "graphic.hpp"

namespace th06_psp {
struct remove_functor {
  bool operator ()(const actor_ptr &ptr) const {
    return !ptr->exist();
  }
};

class framework : private boost::noncopyable {
 public:
  framework()
      : application_(), graphic_(), audio_(), list_(), lua_(lua_open(), &lua_close), lua_top_(lua_top()) {
    list_.log.open("log.txt", std::ios::out | std::ios::app);
    psp::input::init_controller();
    const int result = luaL_dofile(lua_.get(), "script/th06_psp.lua");
    if (result) {
      list_.log << "error: " << lua_tostring(lua_.get(), -1) << std::endl;
    }
    lua_getglobal(lua_.get(), "init");
    const int init_result = lua_pcall(lua_.get(), 0, 0, 0);
    if (init_result) {
      list_.log << "error: " << lua_tostring(lua_.get(), -1) << std::endl;
    }
  }

  void update() {
    const psp::graphic::scoped_render scene;
    psp::graphic::clear_screen();
    psp::input::pool_controller();
    lua_getglobal(lua_.get(), "update");
    const int result = lua_pcall(lua_.get(), 0, 0, 0);
    if (result) {
      list_.log << "error: " << lua_tostring(lua_.get(), -1) << std::endl;
      lua_pop(lua_.get(), 1);
    }
    render();
  }

 private:
  int lua_top() {
    luaL_openlibs(lua_.get());
    glue::init(&list_);
    lua_register(lua_.get(), "add_back_image", &glue::add_back_image);
    lua_register(lua_.get(), "add_image", &glue::add_image);
    lua_register(lua_.get(), "add_bright_image", &glue::add_bright_image);
    lua_register(lua_.get(), "add_box", &glue::add_box);
    lua_register(lua_.get(), "add_text", &glue::add_text);
    lua_register(lua_.get(), "get_actor_position", &glue::get_actor_position);
    lua_register(lua_.get(), "move_to_actor", &glue::move_to_actor);
    lua_register(lua_.get(), "move_actor", &glue::move_actor);
    lua_register(lua_.get(), "resize_actor", &glue::resize_actor);
    lua_register(lua_.get(), "set_actor_uv", &glue::set_actor_uv);
    lua_register(lua_.get(), "set_actor_color", &glue::set_actor_color);
    lua_register(lua_.get(), "set_actor_alpha", &glue::set_actor_alpha);
    lua_register(lua_.get(), "sleep_actor", &glue::sleep_actor);
    lua_register(lua_.get(), "active_actor", &glue::active_actor);
    lua_register(lua_.get(), "erase_actor", &glue::erase_actor);
    lua_register(lua_.get(), "set_bgm", &glue::set_bgm);
    lua_register(lua_.get(), "play_bgm", &glue::play_bgm);
    lua_register(lua_.get(), "stop_bgm", &glue::stop_bgm);
    lua_register(lua_.get(), "pause_bgm", &glue::pause_bgm);
    lua_register(lua_.get(), "set_bgm_volume", &glue::set_bgm_volume);
    lua_register(lua_.get(), "set_se_volume", &glue::set_se_volume);
    lua_register(lua_.get(), "add_se", &glue::add_se);
    lua_register(lua_.get(), "play_se", &glue::play_se);
    lua_register(lua_.get(), "stop_se", &glue::stop_se);
    lua_register(lua_.get(), "key_down", &glue::down);
    lua_register(lua_.get(), "key_triger", &glue::triger);
    lua_pushinteger(lua_.get(), psp::input::kCircle);
    lua_setglobal(lua_.get(), "kCircle");
    lua_pushinteger(lua_.get(), psp::input::kTriangle);
    lua_setglobal(lua_.get(), "kTriangle");
    lua_pushinteger(lua_.get(), psp::input::kCross);
    lua_setglobal(lua_.get(), "kCross");
    lua_pushinteger(lua_.get(), psp::input::kSquare);
    lua_setglobal(lua_.get(), "kSquare");
    lua_pushinteger(lua_.get(), psp::input::kUp);
    lua_setglobal(lua_.get(), "kUp");
    lua_pushinteger(lua_.get(), psp::input::kDown);
    lua_setglobal(lua_.get(), "kDown");
    lua_pushinteger(lua_.get(), psp::input::kLeft);
    lua_setglobal(lua_.get(), "kLeft");
    lua_pushinteger(lua_.get(), psp::input::kRight);
    lua_setglobal(lua_.get(), "kRight");
    lua_pushinteger(lua_.get(), psp::input::kStart);
    lua_setglobal(lua_.get(), "kStart");
    lua_pushinteger(lua_.get(), psp::input::kSelect);
    lua_setglobal(lua_.get(), "kSelect");
    lua_pushinteger(lua_.get(), psp::input::kLeftTriger);
    lua_setglobal(lua_.get(), "kLeftTriger");
    lua_pushinteger(lua_.get(), psp::input::kRightTriger);
    lua_setglobal(lua_.get(), "kRightTriger");
    return lua_gettop(lua_.get());
  }

  void render() {
    //boost::remove_erase_if(object_list_, remove_functor());
    BOOST_FOREACH(const actor_element &element, list_.actor_list) {
      if (element.element->is_active()) {
        element.element->draw();
      }
    }
  }

  const psp::application::initializer application_;
  const psp::graphic::initializer graphic_;
  const psp::audio::initializer audio_;
  list_list list_;
  /*std::vector<actor_ptr> object_list_;
  actor_list_type actor_list_;
  bgm_list_type bgm_list_;
  se_list_type se_list_;
  std::ofstream log_;*/
  const boost::shared_ptr<lua_State> lua_;
  const int lua_top_;
};
}

#endif
