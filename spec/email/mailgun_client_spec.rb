require 'spec_helper'

RSpec.describe Email::Delivery::MailgunClient do

  subject { Email::Delivery::MailgunClient.new }

  context 'methods' do
    %i(dispatch payload sandbox_from).each do |field|
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
    let(:sandbox_from) { subject.sandbox_from }
    let(:payload) { subject.payload(from, to, cc, bcc, sub, body) }

    describe '#payload' do
      it 'is expected to return to, cc and bcc keys' do
        expect(payload.keys).to eq([:from, :to, :subject, :text, :cc, :bcc])
      end
    end

    describe '#from' do
      it 'is expected to return a hash with email key' do
        expect(sandbox_from).not_to be_empty
      end
    end
  end
end
