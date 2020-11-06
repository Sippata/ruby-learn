class Task < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event(:archive) { transition [:new_task, :released] => :archived }
    event(:send_for_development) { transition [:new_task, :in_qa, :in_code_review] => :in_development }
    event(:send_for_qa) { transition in_development: :in_qa }
    event(:send_for_code_review) { transition in_qa: :in_code_review }
    event(:send_for_ready_for_release) { transition in_code_review: :ready_for_release }
    event(:send_for_release) { transition ready_for_release: :released }
  end
end
