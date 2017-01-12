# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :user_id, presence: true
  validate :not_duplicate_response
  validate :author_wont_respond

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_choice_id

  belongs_to :respondent,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user] << "can't answer twice"
    end
  end

  def poll_author_responding?
    answer_choice.question.poll.author == user_id
  end

  def author_wont_respond
    if poll_author_responding?
      errors[:author] << "can't respond to own poll"
    end
  end
end
