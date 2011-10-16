class Report < ActiveRecord::Base
  belongs_to :square
  belongs_to :user
end
