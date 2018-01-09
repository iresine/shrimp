class Question
  include ActiveModel::Model

  attr_accessor :code, :category, :text, :correct_answer

  validates :code, inclusion: [0]
  validates :category, :text, presence: true, if: -> { code.zero? }
  validates :correct_answer, inclusion: [true, false], if: -> { code.zero? }

  def initialize(attributes = {})
    attributes = TriviaService.new(attributes[:category]).call
    super
  end
end
