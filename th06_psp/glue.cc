#include "glue.hpp"
#include <string>
#include <boost/make_shared.hpp>
#include "actor.hpp"
#include "back_image.hpp"
#include "bright_image.hpp"
#include "box.hpp"
#include "controller.hpp"
#include "image.hpp"
#include "shot.hpp"
#include "text.hpp"

namespace th06_psp { namespace global {
std::vector<actor_ptr> *object_list;
actor_list_type *actor_list;
se_list_type *se_list;
bgm_list_type bgm_list;
std::ofstream *log;
}}

namespace boost {
void throw_exception(const std::exception &error) {}
}

namespace th06_psp { namespace glue {
void init(list_list * const list) {
  global::object_list = &list->object_list;
  global::actor_list = &list->actor_list;
  global::bgm_list = list->bgm_list;
  global::se_list = &list->se_list;
  global::log = &list->log;
}

int add_shot(lua_State * const lua) {
  const char * const file_name = lua_tostring(lua, 1);
  const float x = lua_tonumber(lua, 2);
  const float y = lua_tonumber(lua, 3);
  const float width = lua_tonumber(lua, 4);
  const float height = lua_tonumber(lua, 5);
  const float u = lua_tonumber(lua, 6);
  const float v = lua_tonumber(lua, 7);
  lua_settop(lua, 0);
  global::object_list->push_back(boost::make_shared<shot>(file_name, x, y, width, height, u, v));
  return 0;
}

int add_back_image(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const char * const file_name = lua_tostring(lua, 2);
  lua_settop(lua, 0);
  global::actor_list->push_back(actor_element(key, boost::make_shared<back_image>(file_name)));
  return 0;
}

int add_image(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const char * const file_name = lua_tostring(lua, 2);
  lua_settop(lua, 0);
  global::actor_list->push_back(actor_element(key, boost::make_shared<image>(file_name)));
  return 0;
}

int add_bright_image(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const char * const file_name = lua_tostring(lua, 2);
  lua_settop(lua, 0);
  global::actor_list->push_back(actor_element(key, boost::make_shared<bright_image>(file_name)));
  return 0;
}

int add_box(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float x = lua_tonumber(lua, 2);
  const float y = lua_tonumber(lua, 3);
  const float width = lua_tonumber(lua, 4);
  const float height = lua_tonumber(lua, 5);
  lua_settop(lua, 0);
  global::actor_list->push_back(actor_element(key, boost::make_shared<box>(x, y, width, height)));
  return 0;
}

int add_text(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float x = lua_tonumber(lua, 2);
  const float y = lua_tonumber(lua, 3);
  const std::string str = lua_tostring(lua, 4);
  lua_settop(lua, 0);
  global::actor_list->push_back(actor_element(key, boost::make_shared<text>(x, y, str)));
  return 0;
}

int clear_actor_list(lua_State * const lua) {
  global::actor_list->clear();
  return 0;
}

int get_actor_position(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  lua_settop(lua, 0);
  const actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  lua_pushnumber(lua, list.find(key)->element->x());
  lua_pushnumber(lua, list.find(key)->element->y());
  return 2;
}

int move_to_actor(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float x = lua_tonumber(lua, 2);
  const float y = lua_tonumber(lua, 3);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->move_to(x, y);
  return 0;
}

int move_actor(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float x = lua_tonumber(lua, 2);
  const float y = lua_tonumber(lua, 3);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->move(x, y);
  return 0;
}

int resize_actor(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float width = lua_tonumber(lua, 2);
  const float height = lua_tonumber(lua, 3);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->resize(width, height);
  return 0;
}

int set_actor_uv(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const float u = lua_tonumber(lua, 2);
  const float v = lua_tonumber(lua, 3);
  const float width = lua_tonumber(lua, 4);
  const float height = lua_tonumber(lua, 5);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->set_uv(u, v, width, height);
  return 0;
}

int set_actor_color(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const boost::uint8_t red = lua_tointeger(lua, 2);
  const boost::uint8_t green = lua_tointeger(lua, 3);
  const boost::uint8_t blue = lua_tointeger(lua, 4);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->set_color(red, green, blue);
  return 0;
}

int set_actor_alpha(lua_State * const lua) {
  const std::string key = lua_tostring(lua, 1);
  const boost::uint8_t alpha = lua_tointeger(lua, 2);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->set_alpha(alpha);
  return 0;
}

int active_actor(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->set_active(true);
  return 0;
}

int sleep_actor(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.find(key)->element->set_active(false);
  return 0;
}

int erase_actor(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  lua_settop(lua, 0);
  actor_list_type::index<actor_id>::type &list = global::actor_list->get<actor_id>();
  list.erase(key);
  return 0;
}

int set_bgm(lua_State * const lua) {
  const char * const name = lua_tostring(lua, 1);
  const int offset = lua_tointeger(lua, 2);
  lua_settop(lua, 0);
  global::bgm_list = boost::make_shared<psp::audio::bgm>(name, offset);
  return 0;
}

int play_bgm(lua_State * const lua) {
  global::bgm_list->play(0);
  return 0;
}

int stop_bgm(lua_State * const lua) {
  global::bgm_list->stop();
  return 0;
}

int pause_bgm(lua_State * const lua) {
  global::bgm_list->pause();
  return 0;
}

int set_bgm_volume(lua_State * const lua) {
  const int volume = lua_tointeger(lua, 1);
  lua_settop(lua, 0);
  psp::audio::set_volume(0, volume);
  return 0;
}

int set_se_volume(lua_State * const lua) {
  const int volume = lua_tointeger(lua, 1);
  lua_settop(lua, 0);
  for (int i = 1; i < 8; ++i) {
    psp::audio::set_volume(1, volume);
  }
  return 0;
}

int add_se(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  const char * const name = lua_tostring(lua, 2);
  lua_settop(lua, 0);
  global::se_list->insert(std::make_pair(key, boost::make_shared<psp::audio::se>(name)));
  return 0;
}

int play_se(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  const int channel = lua_tointeger(lua, 2);
  lua_settop(lua, 0);
  global::se_list->find(key)->second->play(channel);
  return 0;
}

int stop_se(lua_State * const lua) {
  const char * const key = lua_tostring(lua, 1);
  lua_settop(lua, 0);
  global::se_list->find(key)->second->stop();
  return 0;
}

int down(lua_State * const lua) {
  const psp::input::key_code code = static_cast<psp::input::key_code>(lua_tointeger(lua, 1));
  lua_settop(lua, 0);
  const bool is_down = psp::input::down(code);
  lua_pushboolean(lua, is_down);
  return 1;
}

int triger(lua_State * const lua) {
  const psp::input::key_code code = static_cast<psp::input::key_code>(lua_tointeger(lua, 1));
  lua_settop(lua, 0);
  const bool is_triger = psp::input::triger(code);
  lua_pushboolean(lua, is_triger);
  return 1;
}
}}
