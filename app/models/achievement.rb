class Achievement < ApplicationRecord
  validates :title, presence: true
  enum privacy: [:public_access, :private_access, :friend_access]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description).html_safe
  end

end
