require 'spec_helper'

describe Mailer do
  describe '#contact_form' do
    let(:valid_params) { { name: 'Ivan', email: 'my@email.com', message: 'Love your site!' } }

    it 'fills in email message with details from contact form' do
      mail = Mailer.contact_form(valid_params)
      expect(mail.reply_to).to include('my@email.com')
      expect(mail.to).to include('info@agileventures.org')
      expect(mail.subject).to include('WebsiteOne Contact Form')
      expect(mail.body.raw_source).to include('Love your site!')
    end
    it 'forms a confirmation email for contact_form' do
      mail = Mailer.contact_form_confirmation(valid_params)
      expect(mail.from).to include('info@agileventures.org')
      expect(mail.to).to include('my@email.com')
      expect(mail.subject).to include('WebsiteOne Contact Form')
      expect(mail.body.raw_source).to include('Thank you for your feedback')
    end
  end

  describe '#send_welcome_message' do
    before(:each) do
      @user = User.new first_name: 'Email',
                       last_name: 'Sender',
                       email: 'candice@clemens.com',
                       password: '1234567890'
    end
    it 'should send welcome message' do
       mail = Mailer.send_welcome_message(@user)
       expect(mail.from).to include('info@agileventures.org')
       expect(mail.reply_to).to include('info@agileventures.org')
       expect(mail.to).to include('candice@clemens.com')
       expect(mail.subject).to include('Welcome to AgileVentures.org')
       expect(mail.body.raw_source).to include('Thanks for joining our community! ')
    end
  end
end
