class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  before_action :authenticate_account!
  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
  end

  def current
    respond_to do |format|
      format.json  { render :json => current_account }
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      new_role = @account.role != account_params[:role] ? account_params[:role] : nil
      if @account.update(account_params)

        # # ----------------------------- produce event -----------------------
        # event = {
        #   event_name: 'AccountUpdated',
        #   data: {
        #     public_id: @account.public_id,
        #     email: @account.email,
        #     full_name: @account.full_name,
        #     position: @account.position
        #   }
        # }
        # Produce.call(event.to_json, topic: 'accounts-stream')
        #
        # if new_role
        #   event = {
        #     event_name: 'AccountRoleChanged',
        #     data: { public_id: public_id, role: role }
        #   }
        #   Producer.call(event.to_json, topic: 'accounts')
        # end

        # --------------------------------------------------------------------


        format.html { redirect_to @account, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy # paranoia gem set active and disabled_at values

    # # ----------------------------- produce event -----------------------
    # event = {
    #   event_name: 'AccountDeleted',
    #   data: { public_id: @account.public_id }
    # }
    # Producer.call(event.to_json, topic: 'accounts-stream')
    # # --------------------------------------------------------------------

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def current_account
      if doorkeeper_token
        Account.find(doorkeeper_token.resource_owner_id)
      else
        super
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:full_name, :role)
    end
end
