class Song < ApplicationRecord
  belongs_to :artist

  def self.sort_by_recently_created
    Song.order(created_at: :desc)
  end

  def last_updated
    self.updated_at.strftime("%Y-%m-%d")
  end

  def self.sort_alphabetically
    Song.order(title: :asc)
  end

  def self.shortest_songs(x)
    Song.order(length: :asc).limit(x)
  end

end
