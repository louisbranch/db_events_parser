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

  describe "#parse_array" do

    context "when array doesn't open" do
      let(:blob) { "{date: 2014-01-01, a: 5, b:1}]" }

      it "raises unbalanced ] token" do
        expect{subject.parse_array}.to raise_error("Unbalanced token ]")
      end

    end

    context "when array doesn't close" do
      let(:blob) { "[{date: 2014-01-01, a: 5, b:1}" }

      it "raises unbalanced [] tokens" do
        expect{subject.parse_array}.to raise_error("Unbalanced tokens [ ]")
      end

    end

  end

  describe "#parse_struct" do

    context "when struct synxtax is invalid" do
      let(:blob) { "{date: 2014-01-01, a: 5, b:1" }

      it "raises a struct syntax error" do
        expect{subject.parse_struct}.to raise_error("Unbalanced tokens { }")
      end

    end

    context "when key is missing" do
      let(:blob) { "{2014-01-01, a: 5, b:1}" }

      it "raises a comma syntax error" do
        expect{subject.parse_struct}.to raise_error("Unexpected ',' near '...01-01, a: 5...'")
      end
    end

    context "when value is missing" do
      let(:blob) { "{date: 2014-01-01, a: , b:1}" }

      it "raises a colon syntax error" do
        expect{subject.parse_struct}.to raise_error("Unexpected ',' near '..., a: , b:1...'")
      end
    end

    context "when syntax is valid" do
      let(:blob) { "{date: 2014-01-01, a: 5, b:1}" }

      it "splits key/value pairs" do
        expect(subject.parse_struct).to eq({
          'date' => '2014-01-01',
          'a' => '5',
          'b' => '1'
        })
      end

    end

  end

end
