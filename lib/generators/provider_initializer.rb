module Email
  module Delivery
    class Generator < Rails::Generators::Base
      source_root(File.expand_path(File.dirname(__FILE__)))

      desc "This generator creates an initializer file at config/initializers"
      def copy_initializer_file
        copy_file 'mailgun_creds.rb', 'config/initializers/mailgun_creds.rb'
        copy_file 'sendgrid_creds.rb', 'config/initializers/sendgrid_creds.rb'
      end
    end
  end
end
