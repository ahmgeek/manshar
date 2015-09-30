class Category < ActiveRecord::Base
  include Concerns::Utils

  has_many :topics, :counter_cache => :topics_count, dependent: :destroy
  has_many :articles, :counter_cache => :articles_count

  validates_uniqueness_of :title

  dragonfly_accessor :icon do
    after_assign {|img| self.icon = img.image_optim }
    storage_options do |attachment|
      { headers: {"x-amz-acl" => "public-read-write"} }
    end
  end

  dragonfly_accessor :image do
    after_assign {|img| self.image = img.image_optim }
    storage_options do |attachment|
      { headers: {"x-amz-acl" => "public-read-write"} }
    end
  end

  abs_url_for :icon, :image

end
