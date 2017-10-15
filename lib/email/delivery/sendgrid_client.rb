=begin
    This class acts like a interface.
    It will
    - initialize default mail-client(MailGun)
    - call 'do' method to send the emails.
    - provide fail-over mechanism
=end

require 'net/http'
require 'uri'
require 'json'

module Email
  module Delivery
    class SendgridClient
      def dispatch(from, to, cc, bcc, subject, body)
        response = RestClient.post("#{ENV['SENDGRID_API_URL']}", JSON.dump(payload(from, to, cc, bcc, subject, body)), headers=headers_hash)

        {
            status: response.code,
            message: response.description
        }
      end

      # This method helps to include all recipients defined within the to, cc, and bcc parameters,
      # across each object that you include in the personalizations array.
      def personalizations(to, cc, bcc)
        personalizations_hash = {
            "to" => recepient_list(to)
        }

        unless cc.nil?
          personalizations_hash.merge!({ "cc" => recepient_list(cc) })
        end

        unless bcc.nil?
          personalizations_hash.merge!({ "bcc" => recepient_list(cc) })
        end

        [
            personalizations_hash
        ]
      end

      def from(from)
        {
            "email" => from
        }
      end

      def content(body)
        [
            {
                "type" => "text/plain",
                "value" => body
            }
        ]
      end

      def payload(from, to, cc, bcc, subject, body)
        {
            "personalizations" => personalizations(to, cc, bcc) ,
            "from" => from(from) ,
            "subject" => subject,
            "content" => content(body)
        }
      end

      def headers_hash
        {
            "Authorization" => "Bearer #{ENV['SENDGRID_API_KEY']}",
            "content-type" => "application/json"
        }
      end

      def recepient_list(lst)
        if lst.is_a?(Array)
          lst.map {|elem| {"email" => elem } }
        else
          [
              {
                  "email" => lst
              }
          ]
        end
      end
    end
  end
end
