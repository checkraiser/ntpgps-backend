require 'rails_helper'

describe AddSupportAgentCommand do
  subject(:context) { described_class.call(add_support_agent_params) }
  
    
    it { should validate_presence_of(:email) }
  
    it { should validate_presence_of( :first_name) }
  
    it { should validate_presence_of( :last_name) }
  
    it { should validate_presence_of( :password) }
  
    it { should validate_presence_of( :password_confirmation) }

  describe '.call' do    
    context 'when the context is successful' do
      let(:add_support_agent_params) do
    
      end

      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(:add_support_agent_params) do
    
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end