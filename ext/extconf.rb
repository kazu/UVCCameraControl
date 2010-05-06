require "mkmf"

create_makefile('uvccameracontrol')
["foundation","appkit","iokit"].each do |lib|
  append_library($libs,lib)
end
