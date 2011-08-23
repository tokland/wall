class LiveClassesController < ApplicationController
  before_filter :authorize
   
  def index
    @live_classes = LiveClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @live_classes }
    end
  end

  def show
    @live_class = LiveClass.find(params[:id])
    @note = @live_class.notes.new
    @note.attachments.build

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @live_class }
    end
  end

  def new
    @live_class = LiveClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @live_class }
    end
  end

  def edit
    @live_class = LiveClass.find(params[:id])
  end

  def create
    @live_class = LiveClass.new(params[:live_class])
    @live_class.creator = current_user

    respond_to do |format|
      if @live_class.save
        format.html { redirect_to(live_classes_url, :notice => 'Live class was successfully created.') }
        format.xml  { render :xml => @live_class, :status => :created, :location => @live_class }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @live_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @live_class = LiveClass.find(params[:id])
    forbid unless @live_class.creator == current_user

    respond_to do |format|
      if @live_class.update_attributes(params[:live_class])
        format.html { redirect_to(live_classes_url, :notice => 'Live class was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @live_class.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @live_class = LiveClass.find(params[:id])
    forbid unless @live_class.creator == current_user
    @live_class.destroy

    respond_to do |format|
      format.html { redirect_to(live_classes_url) }
      format.xml  { head :ok }
    end
  end
end
