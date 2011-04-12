#ifndef TH06_PSP_GLUE_HPP_
#define TH06_PSP_GLUE_HPP_
#include <fstream>
#include <lua.hpp>
#include "fwd.hpp"

namespace th06_psp { namespace glue {
void init(actor_list_type *actor_list, const bgm_list_type &bgm_list_, se_list_type *se_list, std::ofstream *log);
int add_back_image(lua_State *lua);
int add_image(lua_State *lua);
int add_bright_image(lua_State *lua);
int add_box(lua_State *lua);
int add_text(lua_State *lua);
int move_actor(lua_State *lua);
int resize_actor(lua_State *lua);
int set_actor_uv(lua_State *lua);
int set_actor_color(lua_State *lua);
int set_actor_alpha(lua_State *lua);
int active_actor(lua_State *lua);
int sleep_actor(lua_State *lua);
int erase_actor(lua_State *lua);
int set_bgm(lua_State *lua);
int add_se(lua_State *lua);
int set_bgm_volume(lua_State *lua);
int set_se_volume(lua_State *lua);
int play_bgm(lua_State *lua);
int play_se(lua_State *lua);
int pause_bgm(lua_State *lua);
int stop_bgm(lua_State *lua);
int stop_se(lua_State *lua);
int down(lua_State *lua);
int triger(lua_State *lua);
}}

#endif
