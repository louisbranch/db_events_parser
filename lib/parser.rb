class Parser

  attr_reader :blob

  def initialize(blob)
    @blob = blob
  end

  def parse_struct
    inner_content = /^\s*\{(.*?)\}\s*$/mx
    match = blob.match(inner_content)
    raise "Invalid data structure syntax" unless match
    extract_key_values(match[1])
  end

  private

  def extract_key_values(text)
    struct = {}
    token_index = 0
    current_key = nil
    text.each_char.with_index do |char, i|
      if char == ':'
        if current_key
          raise "Unexpected ':' near '...#{text[i-5..i+5]}...'"
        else
          current_key = text[token_index..i-1]
          token_index = i + 1
        end
      elsif char == ','
        value = text[token_index..i-1].strip
        if current_key && value.length > 0
          struct[current_key.strip] = value
          current_key = nil
          token_index = i + 1
        else
          raise "Unexpected ',' near '...#{text[i-5..i+5]}...'"
        end
      elsif i == text.length - 1
        if current_key
          struct[current_key.strip] = text[token_index..i].strip
        end
      end
    end
    struct
  end

end
