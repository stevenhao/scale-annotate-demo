class AnnotationRequest < ApplicationRecord
  has_one :annotation_response

  serialize :labels, Array
  validates_length_of :labels, :minimum => 1, :message => "needs at least one label"

  has_attached_file :image, {
    url: "/system/:hash.:extension",
    hash_secret: Rails.application.secrets.secret_key_base
  }
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, less_than: 2.megabytes
end
