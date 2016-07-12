class ApplicantsController < ApplicationController
  before_filter :find_applicant, :only => [:show, :update]
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(initial_applicant_params)
    @applicant.workflow_state = 'applied'
    if @applicant.save
      redirect_to applicant_path(@applicant)
    else
      render 'new'
    end
  end

  def update
    @applicant.update_attribute(:background_check_confirmed, params[:applicant][:background_check_confirmed])
    redirect_to applicant_path(@applicant)
  end

  def show
  end

  private
  def find_applicant
    @applicant = Applicant.find(params[:id])
  end

  def initial_applicant_params
    params.require(:applicant).permit(
      :email,
      :first_name,
      :last_name,
      :region,
      :phone,
      :email,
      :phone_type,
      :source,
      :over_21,
      :reaason
    )
  end
end
