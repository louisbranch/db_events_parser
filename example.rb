require 'parser'
require 'db_events'

blob = <<EOF
[
 {date: 2014-01-01, a: 5, b:1},
 {date: 2014-01-01, xyz: 11},
 {date: 2014-10-10, qbz: 5},
 {date: 2014-10-10, v: 4, q: 1, strpm: -99}
]
EOF

puts 'INPUT'
puts blob

parser = Parser.new(blob)
events = DbEvents.new(parser.parse_array)
events.merge_by!('date')

puts 'OUTPUT'
puts events
