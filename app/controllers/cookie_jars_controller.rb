class CookieJarsController < ApplicationController
  # GET /cookie_jars
  # GET /cookie_jars.json
  def index
    @cookie_jars = CookieJar.all

    @the_cookie_jar = CookieJar.find(3)

    @level = @the_cookie_jar.level

    if @level <100 && @level > 89
      @level = 90
    elsif @level <90 && @level > 79
      @level = 80
    elsif @level <80 && @level > 69
       @level = 70
    elsif @level <70 && @level > 59
       @level = 60
    elsif @level <60 && @level > 49
       @level = 50
    elsif @level <50 && @level > 39
       @level = 40
    elsif @level <40 && @level > 29
       @level = 30
    elsif @level <30 && @level > 19
        @level = 20
    elsif @level <20 && @level > 9
         @level = 10
    elsif @level < 10 && @level > 5
        @level = 5
    end
   
    if @level > 100
      @level = 100
    end
        

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cookie_jars }
    end
  end

  def update_level
    index = params[:level]
    the_cookie_jar = CookieJar.find(3)
    the_cookie_jar.level = index
    the_cookie_jar.save
  end

  # GET /cookie_jars/1
  # GET /cookie_jars/1.json
  def show
    @cookie_jar = CookieJar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cookie_jar }
    end
  end

  # GET /cookie_jars/new
  # GET /cookie_jars/new.json
  def new
    @cookie_jar = CookieJar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cookie_jar }
    end
  end

  # GET /cookie_jars/1/edit
  def edit
    @cookie_jar = CookieJar.find(params[:id])
  end

  # POST /cookie_jars
  # POST /cookie_jars.json
  def create
    @cookie_jar = CookieJar.new(params[:cookie_jar])

    respond_to do |format|
      if @cookie_jar.save
        format.html { redirect_to @cookie_jar, notice: 'Cookie jar was successfully created.' }
        format.json { render json: @cookie_jar, status: :created, location: @cookie_jar }
      else
        format.html { render action: "new" }
        format.json { render json: @cookie_jar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cookie_jars/1
  # PUT /cookie_jars/1.json
  def update
    @cookie_jar = CookieJar.find(params[:id])

    respond_to do |format|
      if @cookie_jar.update_attributes(params[:cookie_jar])
        format.html { redirect_to @cookie_jar, notice: 'Cookie jar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cookie_jar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cookie_jars/1
  # DELETE /cookie_jars/1.json
  def destroy
    @cookie_jar = CookieJar.find(params[:id])
    @cookie_jar.destroy

    respond_to do |format|
      format.html { redirect_to cookie_jars_url }
      format.json { head :no_content }
    end
  end
end
