class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy, :submit_for_acceptance, :accept, :reject]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.list = List.find(params[:list_id])
    authorize @quote
    if @quote.save
      redirect_to @quote, notice: 'Quote was successfully created.'
    else
      flash[:notice] = "Please provide a name for your quote"
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submit_for_acceptance
    @quote.update(status: "awaiting acceptance", rejected_reason: nil)
    redirect_to @quote
  end

  def accept
    @quote.update(status: "accepted", rejected_reason: nil)
    @quote.tasks.update_all(approved: true)
    redirect_to @quote
  end

  def reject
    @quote.update(status: "rejected", rejected_reason: quote_params[:rejected_reason])
    redirect_to @quote
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
    authorize @quote
  end

  # Only allow a list of trusted parameters through.
  def quote_params
    params.require(:quote).permit(:status, :total, :name, :description, :rejected_reason)
  end
end
