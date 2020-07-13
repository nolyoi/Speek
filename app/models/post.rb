# frozen_string_literal: true

class Post < ApplicationRecord
  self.per_page = 10
  include PgSearch::Model
  multisearchable against: [:body]

  belongs_to :user
  belongs_to :community, optional: true
  belongs_to :parent, class_name: 'Post', optional: true

  has_many :likes, dependent: :destroy
  has_many :replies, class_name: 'Post', foreign_key: 'parent_id'
  has_many :echoes, foreign_key: 'source_post_id'

  validates_presence_of :body

  has_many_attached :images

  acts_as_notifiable :users,
                     targets: :custom_notification_users,
                     group: :article,
                     notifier: :user,
                     email_allowed: :custom_notification_email_to_users_allowed?,
                     notifiable_path: :custom_notifiable_path

  before_save :convert_to_markdown

  private

  def convert_to_markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       autolink: true,
                                       space_after_headers: true,
                                       superscript: true,
                                       highlight: true,
                                       footnotes: true)

    self.parsed_body = markdown.render(body)
  end
end
