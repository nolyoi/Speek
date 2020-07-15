# frozen_string_literal: true

class Post < ApplicationRecord
  self.per_page = 10

  belongs_to :user
  belongs_to :community, optional: true
  belongs_to :parent, class_name: 'Post', optional: true

  has_many :likes, dependent: :destroy
  has_many :replies, class_name: 'Post', foreign_key: 'parent_id'
  has_many :echoes, foreign_key: 'source_post_id'

  validates_presence_of :body

  has_many_attached :images

  before_save :convert_to_markdown

  scope :today, -> { where('created_at >= ?', Time.now - 1.day) }

  def self.most_commented
    mc = Post.where('parent_id > 0').group("parent_id").count
    posts = []
    mc.each do |post, cc|
      posts << Post.find(post)
    end
    posts
  end

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
