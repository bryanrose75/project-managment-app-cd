class Task < ApplicationRecord
    belongs_to :project

    after_create_commit {broadcast_prepend_to "tasks"}
    after_update_commit {broadcast_replace_to "tasks"}
    after_destroy_commit {broadcast_remove_to "tasks"}

    has_many :user_tasks
    has_many :users, through: :user_tasks
end
