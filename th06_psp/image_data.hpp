#ifndef TH06_PSP_IMAGE_DATA_HPP_
#define TH06_PSP_IMAGE_DATA_HPP_
#include <cstring>
#include <string>
#include <boost/functional/hash.hpp>
#include <pspiofilemgr.h>
#include "actor.hpp"

namespace th06_psp {
struct image_data {
  explicit image_data(const std::string &key)
      : name_(key), data_(static_cast<unsigned int *>(std::malloc(256 * 256 * sizeof(unsigned int)))) {
    const SceUID fd = sceIoOpen(name_.c_str(), PSP_O_RDONLY, 0777);
    if (fd >= 0) {
      sceIoLseek(fd, 0x80, PSP_SEEK_CUR);
      sceIoRead(fd, data_, 256 * 256 * 4);
      sceIoClose(fd);
    }
  }

  ~image_data() {
    std::free(data_);
  }

  unsigned int *data() const {
    return data_;
  }

 private:
  std::string name_;
  unsigned int *data_;
};
}

#endif
