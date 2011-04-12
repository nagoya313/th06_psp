#ifndef TH06_PSP_APPLICATION_HPP_
#define TH06_PSP_APPLICATION_HPP_
#include <boost/noncopyable.hpp>

namespace psp { namespace application {
class initializer : private boost::noncopyable {
 public:
  initializer();
  ~initializer();
};
}}

#endif
