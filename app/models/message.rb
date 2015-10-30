class Message < ActiveRecord::Base
  belongs_to :channel
  belongs_to :author, class_name: :User
end
