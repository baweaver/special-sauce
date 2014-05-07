require_relative '~/Development/ragnoster.rb'

Pry.config.prompt = [
  # Default Prompt
  proc { |target_self, nest_level, pry|
    Ragnoster.new(
      line:    pry.input_array.size,
      title:   Pry.config.prompt_name,
      nesting: "#{Pry.view_clip(target_self)}#{":#{nest_level}" unless nest_level.zero?}"
    ).build_prompt
  },
  
  # Waiting for Input Prompt
  proc { |target_self, nest_level, pry|
    Ragnoster.new(
      waiting: true
    ).build_prompt
  } 
] 
