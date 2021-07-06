require 'rails_helper'

describe 'Advice Service' do
  it 'retrives advice successfully', :vcr do
    service = AdviceService.new
    response = service.advice_info

    expect(response).to have_key(:slip)
    expect(response[:slip]).to have_key(:advice)
    expect(response[:slip]).to have_key(:id)
  end

  it "emails?" do
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.last

    expect(email.subject).to eq('Nancy Drew is sending you some advice')

    expect(email.reply_to).to eq(['nancydrew@detective.com'])

    expect(email.text_part.body.to_s).to include('Hello Leroy Brown')
    expect(email.text_part.body.to_s).to include('Nancy Drew has sent you some advice:')

    expect(email.html_part.body.to_s).to include('Hello Leroy Brown')
    expect(email.html_part.body.to_s).to include('Nancy Drew has sent you some advice:')
  end
end
