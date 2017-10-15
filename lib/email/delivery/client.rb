=begin
    This class acts like a interface (delegator to provider).
    It will
    - initialize default mail-client(MailGun)
    - call 'do' method to send the emails.
    - provide fail-over mechanism
    - Uses the SendGrid API error codes
        200	OK	Your message is valid, but it is not queued to be delivered. †
        202	ACCEPTED	Your message is both valid, and queued to be delivered.
        400 Bad Request
    - Uses the error codes from MailGun API
        200	Everything worked as expected
        400	Bad Request - Often missing a required parameter
=end
require 'email/delivery/mailgrun_client'
require 'email/delivery/sendgrid_client'

module Email
  module Delivery
    class Client
      attr_accessor :from, :to, :cc, :bcc, :subject, :body, :status, :message

      def initialize(from, to, cc, bcc, subject, body)
        @from = from
        @to = to
        @cc = cc
        @bcc = bcc
        @subject = subject
        @body = body
        @status = nil
        @message = nil
      end

      # Goal of this method is to serve email by one of the service providers
      # In case of a failure return a status code and a failure message.
      def dispatch
        response = Email::Delivery::SendgridClient.new.dispatch(from, to, cc, bcc, subject, body)
        if [200, 202].include?(response[:status])
          status = 0
          message = 'success'
        else
          response = Email::Delivery::MailgunClient.new.dispatch(from, to, cc, bcc, subject, body)
          if response[:status] == 200
            status = 0
            message = 'success'
          else
            status = 4
            message = "Emails failed in sending. The error message is as followed: #{ response[:message] }"
          end
        end

        {status: status, message: message}
      end
    end
  end
end
