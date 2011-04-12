#ifndef TH06_PSP_BIND_HPP_
#define TH06_PSP_BIND_HPP_
#include <string>
#include <boost/function_types/result_type.hpp>
#include <boost/mpl/and.hpp>
#include <boost/mpl/not.hpp>
#include <boost/type_traits/is_enum.hpp>
#include <boost/type_traits/is_float.hpp>
#include <boost/type_traits/is_integral.hpp>
#include <boost/type_traits/is_same.hpp>
#include <boost/type_traits/remove_pointer.hpp>
#include <boost/utility/enable_if.hpp>
#include <lua.hpp>

namespace th06_psp { namespace glue {
template <typename Signature>
struct result_type {
  typedef typename boost::function_types::result_type<typename boost::remove_pointer<Signature>::type>::type type;
};

template <typename T, typename U = void>
struct push;

template <typename T>
struct push<T, typename boost::enable_if<boost::is_same<bool, T> >::type> {
  static void push_value(lua_State * const lua, const bool t) {
    lua_pushboolean(lua, t);
  }
};

template <typename T>
struct push<T, 
            typename boost::enable_if<boost::mpl::and_<boost::mpl::not_<boost::is_same<bool, T> >,
                                      boost::is_integral<T> > >::type> {
  static void push_value(lua_State * const lua, const T t) {
    lua_pushinteger(lua, t);
  }
};

template <typename T>
struct push<T, typename boost::enable_if<boost::is_enum<T> >::type> {
  static void push_value(lua_State * const lua, const T t) {
    lua_pushinteger(lua, t);
  }
};

template <typename T>
struct push<T, typename boost::enable_if<boost::is_float<T> >::type> {
  static void push_value(lua_State * const lua, const T t) {
    lua_pushnumber(lua, t);
  }
};

template <typename T>
struct push<T, typename boost::enable_if<boost::is_same<std::string, T> >::type> {
  static void push_value(lua_State * const lua, const std::string &t) {
    lua_pushstring(lua, t.c_str());
  }
};

template <typename T>
struct push<T, typename boost::enable_if<boost::is_same<const char *, T> >::type> {
  static void push_value(lua_State * const lua, const char * const t) {
    lua_pushstring(lua, t);
  }
};

template <typename Pred>
typename boost::enable_if<boost::is_same<void, typename result_type<Pred>::type>, int>::type 
    glue(lua_State * const lua) {
  return 0;
}

template <typename Pred>
typename boost::disable_if<boost::is_same<void, typename result_type<Pred>::type>, int>::type 
    glue(lua_State * const lua) {
  return 1;
}
}}

#endif
