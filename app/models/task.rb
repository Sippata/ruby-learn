class Task < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :description, length: { maximum: 500 }

  state_machine initial: :new_task do
    event(:send_for_archiving) { transition new_task: :archive, released: :archive }
    event(:send_for_development) do
      transition new_task: :in_development, in_qa: :in_development, in_code_review: :in_development
    end
    event(:send_for_qa) { transition in_development: :in_qa }
    event(:send_for_code_review) { transition in_qa: :in_code_review }
    event(:send_for_prerelease) { transition in_code_review: :ready_for_release }
    event(:send_for_release) { transition ready_for_release: :released }
  end
end
