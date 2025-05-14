class ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_observation, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /observations or /observations.json
  def index
    @observations = Observation.all
  end

  # GET /observations/1 or /observations/1.json
  def show
  end

  # GET /observations/new
  def new
    @observation = Observation.new
  end

  # GET /observations/1/edit
  def edit
  end

  # POST /observations or /observations.json
  def create
    @observation = Observation.new(observation_params)

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: "Observation was successfully created." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("property_new_observation_form", partial: "observations/observation", locals: { observation: @observation })
        end

        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1 or /observations/1.json
  def update
    respond_to do |format|
      if @observation.update(observation_params)
        format.html { redirect_to @observation, notice: "Observation was successfully updated." }
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1 or /observations/1.json
  def destroy
    @observation.destroy!

    respond_to do |format|
      format.html { redirect_to observations_path, status: :see_other, notice: "Observation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def run
    if params[:historical]
      @observation = Observation.find(params.expect(:observation_id))
      @observation_results = RuleApplication.apply_all_rules(@observation, historical: true)
    else
      @observation = Observation.find(params.expect(:observation_id))
      @observation_results = RuleApplication.apply_all_rules(@observation)
      #@observation_results = [{rule: 'blah', is_vulnerable: 'false'}]
    end
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = Observation.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def observation_params
      params.expect(observation: [ :content, :property_id, :observed_at])
    end
end
