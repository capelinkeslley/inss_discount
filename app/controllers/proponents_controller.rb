# frozen_string_literal: true

class ProponentsController < ApplicationController
  before_action :authenticate_user!
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
    respond_to do |format|
      if @proponent.update(proponent_params)
        format.html { redirect_to proponent_url(@proponent), notice: 'Proponent was successfully updated.' }
        format.json { render :show, status: :ok, location: @proponent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proponent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proponents/1 or /proponents/1.json
  def destroy
    @proponent.destroy

    respond_to do |format|
      format.html { redirect_to proponents_url, notice: 'Proponent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_proponent
    @proponent = Proponent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def proponent_params
    params.require(:proponent).permit(:name, :document, :date_of_birth, :main_contact, :secondary_contact,
                                      :gross_salary, :net_salary, :discount)
  end
end