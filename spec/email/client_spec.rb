require 'spec_helper'

RSpec.describe Email::Delivery::Client do

  subject { Email::Delivery::Client.new(nil,nil, nil, nil, nil, nil) }

  context 'attr_accessors' do
    %i(from to cc bcc subject body status message).each do |field|
      it { is_expected.to respond_to("#{field}") }
    end
  end

  context '#dispatch' do
    describe 'happy path' do
      before :each do
        allow_any_instance_of(Email::Delivery::SendgridClient).to receive(:dispatch).and_return({status: 200})
        @response = subject.dispatch
      end

      it 'is expected to call SendGridClient dispatch method' do
        expect(@response[:status]).to eq(0)
      end
    end

    describe 'failover path' do
      before :each do
        allow_any_instance_of(Email::Delivery::SendgridClient).to receive(:dispatch).and_return({status: 400})
        allow_any_instance_of(Email::Delivery::MailgunClient).to receive(:dispatch).and_return({status: 200})
        @response  = subject.dispatch
      end

      it 'is expected to call MailgunClient dispatch method' do
        expect(@response[:status]).to eq(0)
      end
    end

    describe 'failure path' do
      before :each do
        allow_any_instance_of(Email::Delivery::SendgridClient).to receive(:dispatch).and_return({status: 400})
        allow_any_instance_of(Email::Delivery::MailgunClient).to receive(:dispatch).and_return({status: 400})
        @response  = subject.dispatch
      end

      it 'is expected to call MailgunClient dispatch method' do
        expect(@response[:status]).to eq(4)
      end
    end
  end
end
