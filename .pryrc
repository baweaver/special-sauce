require 'launchy'
require 'uri'

# In order to use special variables in commands, they have to
# be injected in from a context that has visibility. It's odd
# that the commands don't have that, but this is a viable
# workaround.
def search_ex_url(ex)
  "http://www.google.com/search?q=#{URI.escape ex.message}"
end

# Same issue as above
def blame(ex)
  file, line = ex.file, ex.line
  raise 'File does not exist!'   unless File.exists?(file)
  raise 'Line must be provided!' unless line
 
  file_directory = file[/^.+\//]
  old_directory  = Dir.pwd
 
  Dir.chdir(file_directory)

  if system('git rev-parse --is-inside-work-tree')
    # Get a +/- 5 sample area of the exception line for context
    start_blame = [1, line.to_i - 5].max
    end_blame   = line.to_i + 5

    raw_blame = 
      `git blame #{file} -L#{start_blame},#{end_blame}`
        .split("\n")
        .map { |s| s.sub(/^.?[0-9a-f]+ +\((\w+ \w+) +.+$/) { |m| $1 } } # Get the names
        .group_by { |s| s }
        .map { |name, values|
          OpenStruct.new(
            name: name,
            chance: ((values.count.to_f / (end_blame - start_blame)) * 100).round(2)
          )
        }
        .sort_by(&:chance)
        .reverse
        .map { |person| "#{person.name}: #{person.chance}% likilihood of involvement" }
        .join("\n")
  else
    raise 'Not a Git Directory!'
  end
 
  Dir.chdir(old_directory)
  raw_blame
end

# Only via a StringIO being interpreted can these values get piped properly
# A small price to pay for the usefulness of these commands. Still need to
# find a better way though...

Pry::Commands.block_command 'search_ex', 'Search the last exception' do
  _pry_.input = StringIO.new 'Launchy.open(search_ex_url(_ex_))'
end

Pry::Commands.block_command 'search_ex_lynx', 'Search the last exception using Lynx' do
  _pry_.input = StringIO.new 'system "lynx #{search_ex_url(_ex_)}"'
end

Pry::Commands.block_command 'blame', 'Gives a list of users likely to be familiar with an exception' do
  _pry_.input = StringIO.new 'puts blame(_ex_)'
end

# Disabled until I can fix the prompts

# require_relative '~/Development/ragnoster.rb'

# Pry.config.prompt = [
  # Default Prompt
#   proc { |target_self, nest_level, pry|
#     Ragnoster.new(
#       line:    pry.input_array.size,
#       title:   Pry.config.prompt_name,
#       nesting: "#{Pry.view_clip(target_self)}#{":#{nest_level}" unless nest_level.zero?}"
#     ).build_prompt
#   },
  
  # Waiting for Input Prompt
#   proc { |target_self, nest_level, pry|
#     Ragnoster.new(
#       waiting: true
#     ).build_prompt
#   } 
# ]

