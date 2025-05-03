class RulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rule, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /rules or /rules.json
  def index
    @rules = Rule.all
  end

  # GET /rules/1 or /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules or /rules.json
  def create
    @rule = Rule.new(rule_params.merge(creator: current_user))

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: "Rule was successfully created." }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1 or /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: "Rule was successfully updated." }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1 or /rules/1.json
  def destroy
    @rule.destroy!

    respond_to do |format|
      format.html { redirect_to rules_path, status: :see_other, notice: "Rule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def rule_params
      params.expect(rule: [ :name, :written_rule, :functional_rule, :example_mitigation ])
    end
end
