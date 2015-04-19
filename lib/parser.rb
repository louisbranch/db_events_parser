class Parser

  attr_reader :blob

  def initialize(blob)
    @blob = blob
  end

  def parse_array
    extract_inner_content(blob, '[', ']')
  end

  def parse_struct
    content = extract_inner_content(blob, '{', '}')
    extract_key_values(content)
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

  def extract_inner_content(text, left_token, right_token)
    structs = []
    token_index = nil
    tokens = 0

    text.each_char.with_index do |char, i|
      case char
      when left_token
        token_index = i unless token_index
        tokens += 1
      when right_token
        tokens -= 1
        if tokens < 0
          raise "Unbalanced token #{right_token}"
        elsif tokens == 0
          structs << text[token_index + 1..i - 1]
          token_index = nil
        end
      end
    end

    if tokens != 0
      raise "Unbalanced tokens #{left_token} #{right_token}"
    end

    structs.first
  end

end
