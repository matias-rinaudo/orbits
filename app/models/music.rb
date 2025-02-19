class Music < ApplicationRecord
	validates :title, :author, :album, :duration, presence: true

	scope :persisted_by_api, -> { where.not(reference_api: nil) }
	scope :persisted_by_system, -> { where(reference_api: nil) }

	def self.ransackable_attributes(auth_object = nil)
    ["album", "author", "title"]
  end

  def persisted_by_system?
  	self.reference_api.nil?
  end
end
