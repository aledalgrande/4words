class Vote < ActiveRecord::Base
  belongs_to :square
  belongs_to :user
end
