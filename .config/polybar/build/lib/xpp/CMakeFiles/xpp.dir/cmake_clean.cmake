file(REMOVE_RECURSE
  "../../../lib/xpp/include/xpp/proto/randr.hpp"
  "../../../lib/xpp/include/xpp/proto/xkb.hpp"
  "../../../lib/xpp/include/xpp/proto/x.hpp"
  "libxpp.pdb"
  "libxpp.a"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/xpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
