# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  validates :text, presence: true, uniqueness: true

  belongs_to :poll,
    class_name: "Poll",
    primary_key: :id,
    foreign_key: :poll_id

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :question_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def n_plus_one_results
    choices = answer_choices

    results = {}
    choices.each do |choice|
      results[choice.text] = choice.responses.count
    end

    results
  end

  def results_using_includes
    choices = answer_choices.includes(:responses)

    results = {}
    choices.each do |choice|
      results[choice.text] = choice.responses.length
    end

    results
  end

  def results
    # self
    #   .answer_choices
    #   .group('answer_choices.id')
    #
  end

end
