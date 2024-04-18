# frozen_string_literal: true

class Contact < ApplicationRecord
  # Classe de contato pertence a kind
  belongs_to :kind, optional: true
  has_many :phones
  has_one :address
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :address, update_only: true

  def phone_count
    phones.count
  end

  def as_json(options = {})
    super(options.merge(except: %i[created_at updated_at])).tap do |hash|
      hash[:birthdate] = I18n.l(birthdate) unless birthdate.blank?
    end
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
