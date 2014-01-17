# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" , :dependent => :destroy
  has_many :uploads, :dependent => :destroy
  attr_accessible :uploads_attributes
  accepts_nested_attributes_for :uploads

end
