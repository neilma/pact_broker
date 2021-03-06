require 'pact_broker/api/decorators/verification_decorator'

module PactBroker
  module Api
    module Decorators
      describe VerificationDecorator do

        let(:verification) do
          instance_double('PactBroker::Domain::Verification',
            number: 1,
            success: true,
            provider_version_number: "4.5.6",
            provider_name: 'Provider',
            consumer_name: 'Consumer',
            build_url: 'http://build-url',
            pact_version_sha: '1234',
            latest_pact_publication: pact_publication,
            execution_date: DateTime.now)
        end

        let(:pact_publication) do
          instance_double('PactBroker::Pacts::PactPublication',
            name: 'A name',
            provider_name: 'Provider',
            consumer_name: 'Consumer',
            consumer_version_number: '1.2.3'
          )
        end

        let(:options) { { user_options: { base_url: 'http://example.org' } } }

        subject { JSON.parse VerificationDecorator.new(verification).to_json(options), symbolize_names: true }

        it "includes the success status" do
          expect(subject[:success]).to eq true
        end

        it "includes the provider version" do
          expect(subject[:providerApplicationVersion]).to eq "4.5.6"
        end

        it "includes the build URL" do
          expect(subject[:buildUrl]).to eq "http://build-url"
        end

        it "includes a link to itself" do
          expect(subject[:_links][:self][:href]).to match %r{http://example.org/.*/verification-results/1}
        end

        it "includes a link to its pact" do
          expect(subject[:_links][:'pb:pact-version'][:href]).to match %r{http://example.org/pacts/}
        end
      end
    end
  end
end
