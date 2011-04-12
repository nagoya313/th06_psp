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
      : name_(key), data_(static_cast<unsigned int *>(std::malloc(128 * 128 * sizeof(unsigned int)))) {
    const SceUID fd = sceIoOpen(name_.c_str(), PSP_O_RDONLY, 0777);
    if (fd >= 0) {
      sceIoLseek(fd, 0x80, PSP_SEEK_CUR);
      if (sceIoRead(fd, data_, 128 * 128 * 4) < 0) {
        *global::log << "file read error" << std::endl;
      }
      sceIoClose(fd);
    } else {
      *global::log << "file loading error" << std::endl;
    }
    *global::log << "file_name: " << key << ", address: " << data_ << std::endl;
  }

  ~image_data() {
    *global::log << "dtr file_name: " << name_ << ", address: " << data_ << std::endl;
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
