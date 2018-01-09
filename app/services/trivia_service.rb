class TriviaService
  class TriviaHttpError < StandardError; end

  API_CATEGORIES_URL = 'https://opentdb.com/api_category.php'.freeze
  API_URL = 'https://opentdb.com/api.php?amount=1&type=boolean'.freeze
  HTTP_OK = 200

  attr_reader :category

  def initialize(category)
    @category = category
  end

  def call
    set_category if @category
    trivia = http_get(API_URL + @category.to_s)
    parse_trivia(trivia)

  rescue TriviaHttpError => e
    { code: e.message.to_i }
  end

  private

  def parse_trivia(trivia)
    results = trivia['results'][0]
    {
      code:           trivia['response_code'],
      category:       (results && results['category']),
      text:           (results && CGI.unescapeHTML(results['question'])),
      correct_answer: (results && (results['correct_answer'] == 'True' ? true : false))
    }
  end

  def http_get(url)
    response = HTTParty.get(url)

    if response.code == HTTP_OK
      response.parsed_response
    else
      raise TriviaHttpError, response.code
    end
  end

  def set_category
    categories = http_get(API_CATEGORIES_URL)['trivia_categories']
    id = categories.detect { |cat| cat['name'] == @category }['id']
    @category = "&category=#{id}"
  end
end
