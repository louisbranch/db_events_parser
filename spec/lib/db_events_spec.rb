require 'db_events'

RSpec.describe DbEvents do

  subject { DbEvents.new(events) }

  describe "#merge_by" do

    context "when key exists" do
      let(:events) do
        [
          {'date' => '2014-01-01', 'a' => '5', 'b' => '1' },
          {'date' => '2014-01-01', 'xyz' => '11'},
          {'date' => '2014-10-10', 'qbz' => '5'},
          {'date' => '2014-10-10', 'v' => '4', 'q' => '1', 'strpm' => '-99'}
        ]
      end

      it "merge events with same key value" do
        expect(subject.merge_by('date')).to eq([
          {'date' => '2014-01-01', 'a' => '5', 'xyz' => '11', 'b' => '1' },
          {'date' => '2014-10-10', 'qbz' => '5', 'v' => '4', 'q' => '1', 'strpm' => '-99'}
        ])
      end

    end

    context "when values are duplicated" do
      let(:events) do
        [
          {'date' => '2014-01-01', 'a' => '5', 'b' => '1' },
          {'date' => '2014-01-01', 'a' => '8'}
        ]
      end

      it "overwrites previous values" do
        expect(subject.merge_by('date')).to eq([
          {'date' => '2014-01-01', 'a' => '8', 'b' => '1' }
        ])
      end

    end

    context "when key is missing" do

      let(:events) do
        [
          {'date' => '2014-01-01', 'a' => '5', 'b' => '1' },
          {'xyz' => '11'},
          {'date' => '2014-01-01', 'qbz' => '5'}
        ]
      end

      it "ignores event" do
        expect(subject.merge_by('date')).to eq([
          {'date' => '2014-01-01', 'a' => '5', 'qbz' => '5', 'b' => '1' }
        ])
      end

    end

  end

end
