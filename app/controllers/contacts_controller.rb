# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    render json: @contacts, methods: :phone_count, include: :address
  end

  # GET /contacts/1
  def show
    render json: @contact, methods: :phone_count,
      include: { kind: model_render_exp,phones: model_render_exp  , address: model_render_exp}
  end

  # POST /contacts
  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact,
             include: [{ kind: { except: %i[created_at updated_at] } }, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact, status: :created, location: @contact,
             include: [{ kind: { except: %i[created_at updated_at] } }, :phones, :address]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    render json: @contact, status: :created, location: @contact,
           include: [{ kind: { except: %i[created_at updated_at] } }, :phones]
  end

  private

  def model_render_exp
    { except: %i[created_at updated_at] }
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_params
    params.require(:contact).permit(:name, :email, :birthdate, :kind_id, phones_attributes: %i[id number _destroy],
                                                                         address_attributes: %i[id street city])
  end
end
