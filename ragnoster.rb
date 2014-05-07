require 'rainbow'
require 'rainbow/ext/string'

class Segment
  attr_accessor :fg, :bg, :content

  def initialize(fg, bg, content)
    @fg = fg
    @bg = bg
    @content = content
  end

  def to_prompt
    Rainbow(" #{@content} ").bg(bg).fg(fg)
  end
end

class Ragnoster
  SEPERATOR  = ''
  DEFAULT_BG = :black
  DEFAULT_FG = :blue

  def initialize(line: 0, title: 'Pry', nesting: 'main', waiting: false)
    @line    = line
    @title   = title
    @nesting = nesting
    @waiting = waiting

    @segments ||= waiting ? waiting_prompt : standard_prompt
  end

  def waiting_prompt
    [
      prompt_head,
      prompt_waiting,
      prompt_title,
      prompt_nesting
    ]
  end

  def standard_prompt
    [prompt_head, prompt_line, prompt_title, prompt_nesting]
  end

  def prompt_head(bg = :black, fg = :red)
    prompt content: 'λ', bg: bg, fg: fg
  end

  def prompt_line(bg = :black, fg = :white)
    prompt content: @line, bg: bg, fg: fg
  end

  def prompt_title(bg = :blue, fg = :black)
    prompt content: @title, bg: bg, fg: fg
  end

  def prompt_nesting(bg = :black, fg = :blue)
    prompt content: @nesting, bg: bg, fg: fg
  end

  def prompt_waiting(bg = :red, fg = :black)
    prompt content: '*', bg: bg, fg: fg
  end

  def prompt(fg: DEFAULT_FG, bg: DEFAULT_BG, content: content)
    Segment.new(fg, bg, content)
  end

  def prompt_seperator(segment, index)
    if index == @segments.length -  1
      Rainbow(SEPERATOR).fg(segment.bg)
    else
      Rainbow(SEPERATOR).fg(segment.bg).bg(@segments[index + 1].bg)
    end
  end

  def build_prompt
    puts '' unless @waiting

    @segments.each_with_index.reduce('') { |current_prompt, (segment, index)|
      current_prompt + segment.to_prompt + prompt_seperator(segment, index)
    } + '  '
  end
end
