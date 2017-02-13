class PartiesController < ApplicationController
  # Index Action
  def index
    if params[:sort].present?
      sort_key = party_params[:sort]
      sort_order = (params[:asc].blank? || params[:asc] == 'true') ? :asc : :desc
      @parties = Party.order_query(sort_key, sort_order)
    else
      @parties = Party.all
    end
  end

  # New Action
  def new
    # so the view shows 0 and not blank
    @party = Party.new(numgsts: 0)
  end

  # Create Action
  def create
    @party = Party.new
    params[:party][:numgsts]=0 if params[:party][:numgsts].blank?

    @party.attributes = party_params[:party]

    # if end is blank, set to end of day
    @party.when_its_over=@party.when.end_of_day if @party.when_its_over.blank?

    if @party.save!
      redirect_to parties_url
    else
      flash[:notice]="Party was incorrect."
      redirect_to new_party_url
    end
  end

  # Strong params
  private
  def party_params
    params.require(:party).permit(:host_name, :host_email, :numgsts, :guest_names, :venue, :location, :theme, :when, :When_its_over, :descript)
  end
end
