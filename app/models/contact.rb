# frozen_string_literal: true

class Contact < ApplicationRecord
  # classe contato pertence a kind
  belongs_to :kind, optional: true
  has_many :phones
  has_one :address

 
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address

  def phone_count
    phones.count
  end

  def as_json(options = {})
    h = super(options)
    h[:birthdate] = (I18n.l(birthdate) unless birthdate.blank?)
    h
  end
  # #Traduzindo para pt - BR
  # def to_br
  #   {
  #     name: name,
  #     email: email,
  #     birthdate: (I18n.l(birthdate) unless birthdate.blank?),
  #     kind: kind.slice(:id, :description)
  #   }
  # end
end
