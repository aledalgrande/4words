require File.join(File.dirname(__FILE__), 'canvas_squares.rb')

namespace :squares do
  desc "Import canvas squares into DB"
  task :import => :environment do
    Square.delete_all
    squares.each do |square|
      Square.create(:x => square[0], :y => square[1], :width => square[2], :height => square[3])
    end
  end
end