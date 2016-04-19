class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /messages
  # GET /messages.json
  def index
    @messages_sended = Message.where(sender: current_user.id)
    @messages = Message.where(user_id: current_user.id)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @user = params[:user] ? User.find_by_dni(params[:user]) : ""
  end

  # GET /messages/1/edit
  def edit
  end

  def hide_sender
    Message.find(params[:message]).update(show_sender: false)
    redirect_to messages_path, notice: 'Message was successfully deleted.'
  end

  def hide_delivered
    Message.find(params[:message]).update(show_recipient: false)
    redirect_to messages_path, notice: 'Message was successfully deleted.'
  end

  # POST /messages
  # POST /messages.json
  def create
    user_id = ((User.find_by_dni(params[:user_id]).nil?) ? false : User.find_by_dni(params[:user_id]).id)
    @message = Message.new(user_id: user_id, content: params[:content], sender: current_user.id)

    respond_to do |format|
      if user_id and @message.save
        @message.save
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to new_message_path, alert: "Make you sure all fields are filled and the DNI belongs to a user" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:content, :user_id, :sender)
  end
end
