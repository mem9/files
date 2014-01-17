class UploadsController < ApplicationController

  before_filter :authenticate_user!


  def index
    @uploads = Upload.where(user_id:current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json:  @uploads.map{|upload| upload.to_jq_upload } }
    end
  end


  def show
    @upload = @user.uploads.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end


  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end


  def create
    @upload = Upload.new(params[:upload])
    @upload.user_id = current_user.id
    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end




  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
  def load_user
    @user=User.find(current_user.id)
  end


end
