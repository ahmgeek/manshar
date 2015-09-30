class Image < ActiveRecord::Base
  include Concerns::Utils

  belongs_to :user

  dragonfly_accessor :asset do
    after_assign {|img| self.asset = img.image_optim }
    storage_options do |attachment|
      { headers: {"x-amz-acl" => "public-read-write"} }
    end
  end
  abs_url_for :asset

end

