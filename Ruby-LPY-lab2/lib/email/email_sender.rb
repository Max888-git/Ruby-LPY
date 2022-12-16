require_relative '../general/user.rb'
require 'pony'

module Email
    class EmailSender
        def initialize
            @server = "smtp.sendgrid.net"
            @port = '587'
            @from = "noreply@rubylab507.site"
            @credentials = EmailCredentials.get_email_credentials
        end

        def send(to, subject, message, attachment)
            Pony.mail({
                :to => to,
                :from => @from,
                :subject => subject,
                :body => message,
                :attachments => { attachment.filename => attachment.filepath },
                :via => :smtp,
                :via_options => {
                  :address        => @server,
                  :port           => @port,
                  :user_name      => @credentials.username,
                  :password       => @credentials.password,
                  :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                }
              })
        end
    end
end