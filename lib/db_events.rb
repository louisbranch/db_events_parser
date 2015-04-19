class DbEvents

  attr_reader :events

  def initialize(events)
    @events = events
  end

  def merge_by(key)
    events.reduce ({}) do |memo, event|
      value = event[key]
      if value
        memo[value] ||= {}
        memo[value].merge!(event)
      end
      memo
    end.values
  end

  def merge_by!(key)
    @events = merge_by(key)
  end

  def to_s
    out = "[\n"
    events.each do |event|
      out << " {"
      out << event.map{|k,v| "#{k}: #{v}"}.join(', ')
      out << "}\n"
    end
    out << "]\n"
  end

end
