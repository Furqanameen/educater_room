class Question < ApplicationRecord
  belongs_to  :quiz

  has_many    :answers, dependent: :destroy

  enum question_types: { mcqs: 0, open_end: 1 }

  validates_presence_of :statement, :question_type

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
