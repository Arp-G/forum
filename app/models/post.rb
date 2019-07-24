class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy

	def make_pdf

		Prawn::Document.new do |pdf|
			pdf.text " <strong>#{title}</strong> <br> #{content} ",:inline_format=>true
		end
	end
end
