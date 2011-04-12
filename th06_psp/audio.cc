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

void stop_callback(void * const buf, const unsigned int length, void * const user_data) {
  std::memset(buf, 0, length);
  *th06_psp::global::log << "stop" << std::endl;
}

void bgm_callback(void * const buf, const unsigned int length, void * const user_data) {
  const bgm_data *data = static_cast<bgm_data *>(user_data);
  boost::uint32_t * const s_buf = reinterpret_cast<boost::uint32_t *>(buf);
  int request_size = 4 * length;
  for (;;) {
    const int read_size = sceIoRead(data->file_id, s_buf, request_size);
    if (request_size == read_size) {
      break;
    } else if (request_size > read_size) {
      request_size -= read_size;
      sceIoLseek(data->file_id, data->intro_offset, PSP_SEEK_SET);
    }
	}
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

bgm::bgm(const char * const file_name, const int offset) : channel_(0), data_() {
  data_.file_id = sceIoOpen(file_name, PSP_O_RDONLY, 0777);
  data_.intro_offset = offset;
  if (data_.file_id >= 0) {
    sceIoLseek(data_.file_id, 0x2C, PSP_SEEK_CUR);
  }
}

bgm::~bgm() {
  if (data_.file_id >= 0) {
    sceIoClose(data_.file_id);
  }
}

void bgm::play(const int channel) {
  channel_ = channel;
  pspAudioSetChannelCallback(channel_, &bgm_callback, reinterpret_cast<void *>(&data_));
}

void bgm::stop() {
  pspAudioSetChannelCallback(channel_, &stop_callback, NULL);
  sceIoLseek(data_.file_id, 0x2C, PSP_SEEK_SET);
}

void bgm::pause() {
  pspAudioSetChannelCallback(channel_, &stop_callback, NULL);
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
  *th06_psp::global::log << "play: " << channel << std::endl;
}

void se::stop() {
  if (channel_) {
    pspAudioSetChannelCallback(channel_, &stop_callback, NULL);
    sceIoLseek(id_, 0x2C, PSP_SEEK_SET);
  }
}

void se::pause() {
  if (channel_) {
    pspAudioSetChannelCallback(channel_, &stop_callback, NULL);
  }
}

void set_volume(const int channel, const int volume) {
  pspAudioSetVolume(channel, volume, volume);
}
}}
