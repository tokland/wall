class NotesController < ApplicationController
  before_filter :load_live_class  

  def sync
    @notes = @live_class.notes.order("created_at DESC")
    @old_state = ActiveSupport::JSON.decode(params[:state] || {})
    @current_state = @notes.mash { |n| [n.id, n.state] }

    respond_to do |format|
      format.json do
        json_notes = @notes.map do |note|
          html = if @current_state[note.id] != @old_state[note.id.to_s] 
            render_to_string({
              :partial => "notes/note.html", 
              :locals => {:live_class => @live_class, :note => note},
            })
          end
          {:id => note.id.to_s, :html => html}
        end                 
        render :json => {:notes => json_notes, :state => @current_state}
      end
    end
  end
    
  def create
    @note = @live_class.notes.new(params[:note])
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html do
          responds_to_parent do
            render :update do |page|
              page.call(params[:cb])
            end
          end         
        end                                    
      else
        format.html do
          responds_to_parent do
            render :update do |page|
              page.alert("error: #{@note.errors.full_messages}")
            end
          end
        end        
      end
    end
  end
  
  def destroy
    @note = @live_class.notes.find(params[:id])
    forbid unless @note.user == current_user

    respond_to do |format|
      if @note.destroy
        format.json { render :json => @note, :status => :ok }
      else
        format.json { render :json => @note, :status => 400 }
      end
    end
  end
  
private

  def load_live_class
    @live_class = LiveClass.find(params[:live_class_id])
  end    
end
