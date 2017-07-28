class Header < ActiveRecord::Base
	has_attached_file :photo, styles: { hight: "1000x1000>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  	validates :title, :photo, presence: true
end
