# vim: ft=ruby:
Pry.config.editor = 'vim'

INPUT_CHAR = '❯'

Pry.prompt = [
    proc do |target_self, nest_level, pry|
        "[#{pry.input_array.size}] \
\001\e[1;37m\002#{Pry.config.prompt_name}\001\e[0m\002\
(\001\e[0;34m\002#{Pry.view_clip(target_self)}\001\e[0m\002)\
#{":#{nest_level}" unless nest_level.zero?} \
\001\e[1;32m\002#{INPUT_CHAR}\001\e[0m\002 "
    end,

    proc do |target_self, nest_level, pry|
        "[#{pry.input_array.size}] \
\001\e[1;37m\002#{Pry.config.prompt_name}\001\e[0m\002\
(\001\e[0;34m\002#{Pry.view_clip(target_self)}\001\e[0m\002)\
#{":#{nest_level}" unless nest_level.zero?} * "
    end
]


