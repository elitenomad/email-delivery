require 'spec_helper'

RSpec.describe Email::Delivery::SendgridClient do

  subject { Email::Delivery::SendgridClient.new }

  context 'methods' do
    %i(personalizations from content payload headers_hash recepient_list dispatch).each do |field|
      it { is_expected.to respond_to("#{field}") }
    end
  end

  context '#method return values' do
      let(:from) { 'test@test.com' }
      let(:to) { 'test_to@test.com' }
      let(:to_list) { 'test_to@test.com,test_to_1@test.com'}
      let(:cc) { 'test_cc@test.com' }
      let(:bcc) { 'test_bcc@test.com' }
      let(:sub) { 'Its a sample test' }
      let(:body) { 'Its a simple test body' }
      let(:personalizations) { subject.personalizations(to, cc, bcc)[0] }
      let(:from_method) { subject.from(from) }
      let(:content_body) { subject.content(body)[0] }
      let(:payload) { subject.payload(from, to, cc, bcc, sub, body) }
      describe '#personalizations' do
        it 'is expected to return to, cc and bcc keys' do
          expect(personalizations.keys).to eq(["to","cc","bcc"])
        end
      end

      describe '#from' do
        it 'is expected to return a hash with email key' do
          expect(from_method.keys).to eq(["email"])
        end
      end

      describe '#content_body' do
        it 'is expected to return type and value hash' do
          expect(content_body.keys).to eq(['type','value'])
        end
      end

      describe '#payload' do
        it 'is expected to return a hash with keys' do
          expect(payload.keys).to eq(["personalizations", "from", "subject", "content"])
        end
      end

      describe '#headers_hash' do
        it 'is expected to return a hash with content-Type and Authorization' do
          expect(subject.headers_hash.keys).to eq( ["Authorization", "content-type"])
        end
      end

  end
end
