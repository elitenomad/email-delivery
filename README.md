# Email::Delivery

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library 
into a gem. Put your Ruby code in the file `lib/email/delivery`. To experiment with that code, run `bin/console` 
for an interactive prompt.

This gem is a service (Backend) that accepts the necessary information and sends emails. It provides an abstraction 
between two different e-mail service providers and quickly falls over to a working provider without affecting the users.
It expects the credentials are set in the application the gem is imported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'email-delivery'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email-delivery

## Inputs
    
    Input: Hash
    {
        'from':'me@test.com',
        'to':'you_1@test.com, you_2@test.com',
        'cc':'you_3@test.com',
        'bcc':['you_4@test.com', 'test_bcc2@mail.com'],
        'subject':'test subject',
        'text':'Hey testing now...'
    }
    
    Output: Hash
    {
        'status': 0 || 4
        'message: 'success' || 'failure'
    }
    
## Usage

    mail = Email::Delivery::Client.new do
      from     'me@test.com'
      to       'you@test.com'
      subject  'Test subject'
      body     'Hey testing now...'
    end
    
    mail.dispatch
    
## Test

    ### Send email with one email address
    
        mail = Email::Delivery::Client.new do
              from     'me@test.com'
              to       'you@test.com'
              subject  'Test subject'
              body     'Hey testing now...'
            end
            
        output_hash = mail.dispatch
        {
          "message": "success", 
          "status": 0
        }
    
    ### send email with multiple emails,CC and BCC
    
         mail = Email::Delivery::Client.new do
                  from     'me@test.com'
                  to       'you@test.com', 'you_1@test.com'
                  cc       'you_2@test.com'
                  bcc      'you_3@test.com'
                  subject  'Test subject'
                  body     'Hey testing now...'
               end
                  
         output_hash = mail.dispatch
         {
             "message": "success", 
             "status": 0
         }
     
    ### send email and receive error message
        mail = Email::Delivery::Client.new do
                      from     'me@test.com'
                      to       ''
                      cc       'BlahBlah'
                      bcc      'YoYo'
                      subject  'Test subject'
                      body     'Hey testing now...'
                   end
                      
        output_hash = mail.dispatch
        
        {
          "message": "Error message returned from service provider", 
          "status": 2
        }

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Issues
    Mailgun set-up issues with netregistry

## Limitations
    Mailgun is running with sandbox environment. So only Authorized receipients could receive email.
    Service assumes any string which passes a email regex is a valid email.
    Service handles only sending emails and won't inform about dropped messages or rejected messages.
    
## Improvements
    Message builder and formatter for the mail clients based on the input.
    API Client exceptions based on api error codes with user friendly messages.
    
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elitenomad/email-delivery.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
