=begin
    This class acts like a interface.
    It will
    - initialize default mail-client(MailGun)
    - call 'do' method to send the emails.
    - provide fail-over mechanism
=end

require 'rest-client'

module Email
  module Delivery
    class MailgunClient
      def initialize
        @api_url = "https://api:#{ENV['MAILGUN_API_KEY']}@#{ENV['MAILGUN_API_URL']}"
      end

      def dispatch(from, to, cc, bcc, subject, body)
        response = RestClient.post @api_url, payload(from, to, cc, bcc, subject, body)

        {
            status: response.code,
            message: response.description
        }
      end

      def payload(from, to, cc, bcc, subject, body)
        data = {}
        data[:from] = sandbox_from
        data[:to] = to
        data[:subject] = subject
        data[:text] = body
        unless cc.nil?
          data[:cc] = cc
        end

        unless bcc.nil?
          data[:bcc] = bcc
        end
        data
      end

      # Requires a custom domain setup
      # https://app.mailgun.com/app/domains/new to manage custom 'from'
      def sandbox_from
        "Mailgun Sandbox <postmaster@sandboxd76a53e1a7614050ad917bab34226253.mailgun.org>"
      end
    end
  end
end


