require 'rails_helper'

RSpec.describe QuestionsController do
  let(:question) { FactoryBot.build(:question) }
  let(:invalid_question) { FactoryBot.build(:question, :invalid_question) }

  describe 'GET #show' do
    context 'when valid question' do
      before do
        allow(Question).to receive(:new).and_return(question)
      end
      it 'renders show' do
        get :show
        expect(response).to be_success
        expect(response).to render_template :show
      end
    end

    context 'when invalid question' do
      before do
        allow(Question).to receive(:new).and_return(invalid_question)
      end
      it 'renders service_unavailable' do
        get :show
        expect(response).to be_success
        expect(response).to render_template :service_unavailable
      end
    end
  end

  describe 'POST #answer' do
    context 'when answer is true' do
      it 'renders correct' do
        post :answer, params: { answer: 'correct', category: 'category' }
        expect(response).to render_template :correct, params: { category: 'category' }
      end
    end

    context 'when answer is false' do
      it 'renders wrong' do
        post :answer, params: { category: 'category' }
        expect(response).to render_template :wrong, params: { category: 'category' }
      end
    end
  end

  describe 'GET #show_category' do
    context 'when valid question' do
      before do
        allow(Question).to receive(:new).and_return(question)
      end
      it 'renders show' do
        get :show_category
        expect(response).to be_success
        expect(response).to render_template :show
      end
    end

    context 'when invalid question' do
      before do
        allow(Question).to receive(:new).and_return(invalid_question)
      end
      it 'renders service_unavailable' do
        get :show_category
        expect(response).to be_success
        expect(response).to render_template :service_unavailable
      end
    end
  end
end
