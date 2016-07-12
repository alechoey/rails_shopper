class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(initial_applicant_params)
    @applicant.workflow_state = 'applied'
    redirect_to applicant_path(@applicant)
  end

  def update
    # your code here
  end

  def show
    # your code here
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
