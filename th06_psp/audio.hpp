#ifndef TH06_PSP_AUDIO_HPP_
#define TH06_PSP_AUDIO_HPP_
#include <boost/cstdint.hpp>
#include <boost/noncopyable.hpp>
#include <pspiofilemgr.h>

namespace psp { namespace audio {
class initializer : private boost::noncopyable {
 public:
  initializer();
  ~initializer();
};

class bgm : private boost::noncopyable {
 public:
  bgm(const char *file_name, int offset);
  ~bgm();
  void play(int channel);
  void stop();
  void pause();
  bool is_stop() const;
  SceUID file_id() const;
  int intro_offset() const;

 private:
  int channel_;
  bool is_stop_;
  const SceUID file_id_;
  const int intro_offset_;
};

class se : private boost::noncopyable {
 public:
  explicit se(const char *file_name);
  ~se();
  void play(int channel);
  void stop();
  void pause();

 private:
  const SceUID id_;
  int channel_;
};

void set_volume(int channel, int volume);
}}

#endif
