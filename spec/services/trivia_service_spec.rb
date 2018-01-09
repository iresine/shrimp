require 'rails_helper'

RSpec.describe TriviaService do
  API_URL = TriviaService::API_URL
  API_CATEGORIES_URL = TriviaService::API_CATEGORIES_URL
  HTTP_NOT_FOUND = 404
  VALID_API_CODE = 0
  INVALID_API_CODE = 1

  describe '#call' do
    context 'when external api is available' do
      let(:category) { 'Science: Computers' }
      let(:text) { 'The IBM PC used an Intel 8008 microprocessor clocked at 4.77 MHz and 8 kilobytes of memory.' }
      let(:correct_answer) { false }

      it 'returns question parameters' do
        valid_question = JSON.parse(file_fixture('question_computers.json').read)
        allow_any_instance_of(described_class).to receive(:http_get).with(API_URL).and_return(valid_question)
        expect_any_instance_of(described_class).to receive(:http_get).with(API_URL).and_return(valid_question)

        service = described_class.new(nil)
        result = service.call

        expect(result[:correct_answer]).to eq correct_answer
        expect(result[:text]).to eq text
        expect(result[:category]).to eq category
        expect(result[:code]).to eq VALID_API_CODE
      end
    end

    context 'when external api is not available' do
      it 'returns http error code' do
        allow_any_instance_of(described_class).to receive(:http_get).with(API_URL).and_raise(TriviaService::TriviaHttpError, HTTP_NOT_FOUND)

        service = described_class.new(nil)
        result = service.call
        expect(result[:code]).to eq HTTP_NOT_FOUND
      end
    end

    context 'external api sends error code' do
      it 'returns external api error code' do
        invalid_question = JSON.parse(file_fixture('question_invalid.json').read)
        allow_any_instance_of(described_class).to receive(:http_get).with(API_URL).and_return(invalid_question)

        service = described_class.new(nil)
        result = service.call
        expect(result[:code]).to eq INVALID_API_CODE
      end
    end
  end

  describe '#set_category' do
    let(:category) { 'Science: Computers' }
    let(:category_id) { 18 }

    it 'set category to include id' do
      categories = JSON.parse(file_fixture('categories.json').read)
      allow_any_instance_of(described_class).to receive(:http_get).with(API_CATEGORIES_URL).and_return(categories)
      expect_any_instance_of(described_class).to receive(:http_get).with(API_CATEGORIES_URL).and_return(categories)

      service = described_class.new(category)
      service.send(:set_category)

      expect(service.category).to eq "&category=#{category_id}"
    end
  end
end
