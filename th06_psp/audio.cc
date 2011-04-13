#include "audio.hpp"
#include <cstring>
#include <fstream>
#include <vector>
#include <boost/cstdint.hpp>
#include <pspaudio.h>
#include <pspaudiolib.h>

namespace th06_psp { namespace global {
extern std::ofstream *log;
}}

namespace psp { namespace audio { namespace {
struct sample_t {
  boost::int16_t l;
  boost::int16_t r;
};

void bgm_callback(void * const buf, const unsigned int length, void * const user_data) {
  const bgm * const data = static_cast<bgm *>(user_data);
  boost::uint32_t * const s_buf = reinterpret_cast<boost::uint32_t *>(buf);
  int request_size = 4 * length;
  for (;;) {
    const int read_size = sceIoRead(data->file_id(), s_buf, request_size);
    if (request_size == read_size) {
      break;
    } else if (request_size > read_size) {
      request_size -= read_size;
      sceIoLseek(data->file_id(), data->intro_offset(), PSP_SEEK_SET);
    }
	}
   *th06_psp::global::log << "play: " << std::endl;
}

void se_callback(void * const buf, const unsigned int length, void * const user_data) {
  const SceUID file_id = reinterpret_cast<SceUID>(user_data);
  sample_t * const s_buf = reinterpret_cast<sample_t *>(buf);
  int request_size = 4 * length;
  std::vector<boost::int8_t> temp(length / 2);
  const int read_size = sceIoRead(file_id, temp.data(), temp.size());
  if (read_size) {
    for (int i = 0; i < read_size; ++i) {
      for (int j = 0; j < 2; ++j) {
        s_buf[i * 2 + j].r = s_buf[i * 2 + j].l = (temp[i] - 128) * 256;
      }
    }
    if (length > static_cast<unsigned int>(read_size * 4)) {
      std::memset(reinterpret_cast<char *>(s_buf) + read_size * 4, 0, request_size - read_size * 4);
    }
  } else {
    std::memset(s_buf, 0, request_size);
  }
}
}}}

namespace psp { namespace audio {
initializer::initializer() {
  pspAudioInit();
}

initializer::~initializer() {
  pspAudioEnd();
}

bgm::bgm(const char * const file_name, const int offset)
    : channel_(0), is_stop_(true), file_id_(sceIoOpen(file_name, PSP_O_RDONLY, 0777)), intro_offset_(offset) {
  if (file_id_ >= 0) {
    sceIoLseek(file_id_, 0x2C, PSP_SEEK_CUR);
  }
  *th06_psp::global::log << file_name << std::endl;
}

bgm::~bgm() {
  if (file_id_ >= 0) {
    sceIoClose(file_id_);
  }
}

void bgm::play(const int channel) {
  channel_ = channel;
  pspAudioSetChannelCallback(channel_, &bgm_callback, reinterpret_cast<void *>(this));
}

void bgm::stop() {
  pspAudioSetChannelCallback(channel_, NULL, NULL);
  sceIoLseek(file_id_, 0x2C, PSP_SEEK_SET);
}

void bgm::pause() {
  pspAudioSetChannelCallback(channel_, NULL, NULL);
}

bool bgm::is_stop() const {
  return is_stop_;
}

SceUID bgm::file_id() const {
  return file_id_;
}

int bgm::intro_offset() const {
  return intro_offset_;  
}

se::se(const char * const file_name) : id_(sceIoOpen(file_name, PSP_O_RDONLY, 0777)), channel_(0) {
  if (id_ >= 0) {
    sceIoLseek(id_, 0x2C, PSP_SEEK_CUR);
  }
}

se::~se() {
  if (id_ >= 0) {
    sceIoClose(id_);
  }
}

void se::play(const int channel) {
  channel_ = channel;
  pspAudioSetChannelCallback(channel_, &se_callback, reinterpret_cast<void *>(id_));
}

void se::stop() {
  if (channel_) {
    pspAudioSetChannelCallback(channel_, NULL, NULL);
    sceIoLseek(id_, 0x2C, PSP_SEEK_SET);
  }
}

void se::pause() {
  if (channel_) {
    pspAudioSetChannelCallback(channel_, NULL, NULL);
  }
}

void set_volume(const int channel, const int volume) {
  pspAudioSetVolume(channel, volume, volume);
}
}}
