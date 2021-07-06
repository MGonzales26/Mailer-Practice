require 'rails_helper'

RSpec.describe FriendNotifierMailer, type: :mailer do
  describe "inform" do
    sending_user = User.create(
      first_name: 'Rey',
      last_name: 'Palpatine',
      email: 'rey@dropofgoldensun.com',
      password: 'thebestjedi'
    )

    email_info = {
      user: sending_user,
      friend: 'Kylo Ren',
      message: 'Work through your anger with exercise, and wear a mask'
    }

    let(:mail) { FriendNotifierMailer.inform(email_info, 'kyloren@besties.com') }

    it 'renders the headers' do
      expect(mail.subject).to eq("Rey Palpatine is sending you some advice")
      expect(mail.to).to eq(['kyloren@besties.com'])
      expect(mail.from).to eq(['friendly@advice.io'])
      expect(mail.reply_to).to eq(['rey@dropofgoldensun.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('Hello Kylo Ren')
      expect(mail.text_part.body.to_s).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')

      expect(mail.html_part.body.to_s).to include('Hello Kylo Ren')
      expect(mail.html_part.body.to_s).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')

      expect(mail.body.encoded).to include('Hello Kylo Ren')
      expect(mail.body.encoded).to include('Rey Palpatine has sent you some advice: Work through your anger with exercise, and wear a mask')
    end
  end
end