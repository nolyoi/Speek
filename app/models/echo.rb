class Echo < ApplicationRecord
  belongs_to :echoer, class_name: "User"
  belongs_to :source_post, class_name: "Post"

  validates_presence_of :echoer
end
