class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:approve, :show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = policy_scope(Invoice)
    @need_approval = @invoices.where(approved: false).where.not(issued_at: nil)
    @due = @invoices.where("due_by > ? and paid = ?", Time.now, false)
    @overdue = @invoices.where("due_by < ? and paid = ?", Time.now, false)
    @paid = @invoices.where(paid: true)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show

  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    authorize @invoice
  end

  # GET /invoices/1/edit
  def edit
  end

  def approve
    @invoice.update(approved: true)
    redirect_to invoices_path
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    authorize @invoice
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
    authorize @invoice
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit(:user_id)
  end
end
