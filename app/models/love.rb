class Love < ActiveRecord::Base
  belongs_to :loveable, polymorphic: true
end
