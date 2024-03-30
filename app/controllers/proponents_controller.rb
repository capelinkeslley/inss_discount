# frozen_string_literal: true

class ProponentsController < ApplicationController
  before_action :authenticate_user!, except: :calculate_discount
  before_action :set_proponent, only: %i[show edit update destroy]

  # GET /proponents or /proponents.json
  def index
    @proponents = Proponent.page(params[:page]).per(5)
  end

  # GET /proponents/1 or /proponents/1.json
  def show; end

  # GET /proponents/new
  def new
    @proponent = Proponent.new
  end

  # GET /proponents/1/edit
  def edit; end

  # POST /proponents or /proponents.json
  def create
    @proponent = Proponent.new(proponent_params)

    respond_to do |format|
      if @proponent.save
        format.html { redirect_to proponent_url(@proponent), notice: 'Proponent was successfully created.' }
        format.json { render :show, status: :created, location: @proponent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proponents/1 or /proponents/1.json
  def update
    success_callback = lambda do |_|
      respond_to do |format|
        format.html { redirect_to proponent_url(@proponent), notice: 'Enviado para atualização' }
        format.json { render :show, status: :ok, location: @proponent }
      end
    end

    error_callback = lambda do |caller|
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: caller.errors, status: :unprocessable_entity }
      end
    end

    ProponentServices::Update.perform(
      proponent_params,
      @proponent,
      { success: success_callback, error: error_callback }
    )
  end

  # DELETE /proponents/1 or /proponents/1.json
  def destroy
    @proponent.destroy

    respond_to do |format|
      format.html { redirect_to proponents_url, notice: 'Proponent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calculate_discount
    render json: { discount: !gross_salary.zero? ? ProponentServices::CalculateDiscount.perform(gross_salary:) : 0 }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def proponent_params
    params.require(:proponent).permit(:name, :document, :date_of_birth, :main_contact, :secondary_contact,
                                      :gross_salary, :discount)
  end

  def gross_salary
    params[:gross_salary].to_f
  end
end
