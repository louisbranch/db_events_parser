class Parser

  attr_reader :blob

  def initialize(blob)
    @blob = blob
  end

  def parse_struct
    inner_content = /^\s*\{(.*?)\}\s*$/mx
    match = blob.match(inner_content)
    raise "Invalid data structure syntax" unless match
    match[1]
  end

end
