class Schoolnews < ActiveRecord::Base
	belongs_to :user
    validates  :user_id, presence: true
    
    validates  :title,   presence: true, length:{ maximum: 50 }
    validates_uniqueness_of :title
	default_scope -> { order('created_at DESC') }

end
