#ifndef TH06_PSP_FWD_HPP_
#define TH06_PSP_FWD_HPP_
#include <string>
#include <boost/multi_index_container.hpp>
#include <boost/multi_index/member.hpp>
#include <boost/multi_index/ordered_index.hpp>
#include <boost/multi_index/sequenced_index.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/unordered_map.hpp>
#include "actor.hpp"
#include "audio.hpp"

namespace th06_psp {
typedef boost::multi_index::multi_index_container<
              actor_element,
              boost::multi_index::indexed_by<
	                boost::multi_index::sequenced<>,                           
	                boost::multi_index::ordered_unique<
                      boost::multi_index::tag<actor_id>,
                      boost::multi_index::member<actor_element, std::string, &actor_element::id> > > > actor_list_type;

typedef boost::unordered_map<std::string, boost::shared_ptr<psp::audio::se> > se_list_type;
typedef boost::shared_ptr<psp::audio::bgm> bgm_list_type; 
}


#endif
