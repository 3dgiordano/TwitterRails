class TwitsController < ApplicationController
  # GET /twits
  # GET /twits.json
  def index
    @twits = Twit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @twits }
    end
  end

  # GET /twits/1
  # GET /twits/1.json
  def show
    @twit = Twit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @twit }
    end
  end

  # GET /twits/new
  # GET /twits/new.json
  def new
    @twit = Twit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @twit }
    end
  end

  # GET /twits/1/edit
  def edit
    @twit = Twit.find(params[:id])
  end

  # POST /twits
  # POST /twits.json
  def create
    @twit = Twit.new(params[:twit])

    respond_to do |format|
      if @twit.save
        format.html { redirect_to @twit, notice: 'Twit was successfully created.' }
        format.json { render json: @twit, status: :created, location: @twit }
      else
        format.html { render action: "new" }
        format.json { render json: @twit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /twits/1
  # PUT /twits/1.json
  def update
    @twit = Twit.find(params[:id])

    respond_to do |format|
      if @twit.update_attributes(params[:twit])
        format.html { redirect_to @twit, notice: 'Twit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @twit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twits/1
  # DELETE /twits/1.json
  def destroy
    @twit = Twit.find(params[:id])
    @twit.destroy

    respond_to do |format|
      format.html { redirect_to twits_url }
      format.json { head :no_content }
    end
  end
end
