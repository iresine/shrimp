require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    context 'if code valid' do
      it { is_expected.to validate_inclusion_of(:code).in_array([0]) }
      it { should validate_presence_of(:text) }
      it { should validate_presence_of(:category) }
      it { should validate_inclusion_of(:correct_answer).in_array([true, false]) }
    end

    context 'if code not valid' do
      before { allow(subject).to receive(:code) { 400 } }
      it { should_not validate_presence_of(:text) }
      it { should_not validate_presence_of(:category) }
      it { should_not validate_inclusion_of(:correct_answer) }
    end
  end
end
