require 'spec_helper'
require 'pact_broker/models/group'
require 'pact_broker/models/relationship'

module PactBroker
  module Models
    describe Group do


      describe "#include_pacticipant" do

        let(:consumer_a) { double('consumer a') }
        let(:consumer_b) { double('consumer b') }

        let(:provider_x) { double('provider x') }
        let(:provider_y) { double('provider y') }

        let(:relationship_1) { Models::Relationship.new(consumer_a, provider_x)}
        let(:relationship_2) { Models::Relationship.new(consumer_b, provider_y)}

        subject { Group.new(relatio)}
      end

    end
  end
end