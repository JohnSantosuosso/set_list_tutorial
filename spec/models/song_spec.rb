require 'rails_helper'

RSpec.describe Song, type: :model do
  it {should belong_to :artist}

  describe 'instance methods' do
    describe 'last_updated' do
      it 'returns the date the instance was last updated' do
        artist = Artist.create(name: 'Prince')
        song = artist.songs.create(title: 'kiss', play_count: 5832, length: 700)
        updated_time = Time.zone.now

        song.update(title: 'Kiss', updated_at: updated_time)

        expect(song.last_updated).to eq(updated_time.strftime("%Y-%m-%d"))
      end
    end
  end

  describe 'class methods' do
    describe 'sort_by_recently_created' do
      it 'returns songs ordered by most recent creation' do
        artist = Artist.create(name: 'Prince')
        kiss = artist.songs.create(title: 'Kiss', play_count: 8962011, length: 300)
        beret = artist.songs.create(title: 'Raspberry Beret', play_count: 462291, length: 300)
        rain = artist.songs.create(title: 'Purple Rain', play_count: 8000000, length: 300)
        expect(Song.sort_by_recently_created).to eq([rain, beret, kiss])
      end
    end
  end

  describe '::by_title_alphabetically' do
      it 'returns songs ordered by title alphabetically' do
        artist = Artist.create(name: 'Prince')
        kiss = artist.songs.create(title: 'Kiss', play_count: 8962011, length: 300)
        beret = artist.songs.create(title: 'Raspberry Beret', play_count: 462291, length: 300)
        rain = artist.songs.create(title: 'Purple Rain', play_count: 8000000, length: 300)
        expect(Song.sort_alphabetically).to eq([kiss, rain, beret])
      end
  end

  describe '::shortest_songs limited' do
      it 'returns the shortest songs with a limit sent by the user' do
        artist = Artist.create(name: 'Prince')
        kiss = artist.songs.create(title: 'Kiss', play_count: 8962011, length: 350)
        beret = artist.songs.create(title: 'Raspberry Beret', play_count: 462291, length: 400)
        rain = artist.songs.create(title: 'Purple Rain', play_count: 8000000, length: 300)
        expect(Song.shortest_songs(2)).to eq([rain, kiss])
      end
  end
end
