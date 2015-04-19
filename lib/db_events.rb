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

end
