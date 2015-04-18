require 'parser'

RSpec.describe Parser do

  let(:blob) do
    blob = <<EOF
[
 {date: 2014-01-01, a: 5, b:1},
 {date: 2014-01-01, xyz: 11},
 {date: 2014-10-10, qbz: 5},
 {date: 2014-10-10, v: 4, q: 1, strpm: -99}
]
EOF
  end

  subject { Parser.new(blob) }

  describe "#parse_struct" do

    context "when struct synxtax is invalid" do
      let(:blob) { "{date: 2014-01-01, a: 5, b:1" }

      it "raises an error" do
        expect{subject.parse_struct}.to raise_error("Invalid data structure syntax")
      end

    end

    context "when syntax is valid" do
      let(:blob) { "{date: 2014-01-01, a: 5, b:1}" }

      xit "split key/value pairs" do
        expect(subject.parse_struct).to eq({
          'date' => '2014-01-01',
          'a' => '5',
          'b' => '1'
        })
      end

    end

  end

end
