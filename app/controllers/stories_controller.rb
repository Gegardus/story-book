class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.all.order(created_at: :desc)
  end

  def new
    @story = Story.new
  end
  
  def show; end

  def create
    @story = Story.new(story_params)
    respond_to do |format|
      if @story.save
        format.html { redirect_to stories_path, notice: "Story was successfully destroyed." }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to stories_path }
        # Here, without refreshing the website, the user interface will reflect with those stories which are updated into the database
        format.turbo_stream { render turbo_stream: turbo_stream.replace("story_#{@story.id}", partial: 'story', locals: { story: @story }) }
      else
        format.html { redirect_to edit_story_path }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @story.destroy
        format.html { redirect_to stories_path }
        # using turbo_frame helper, the request is sent as turbo_stream format when submitting a form. 
        # Therefore, responses must be sent back in the same turbo_stream format. 
        # Therefore, we created a turbo_stream.erb file using the response_to block in this
        format.turbo_stream
      else
        format.html { redirect_to stories_path, notice: @story.errors.full_message }
      end
    end
  end

  private
  def story_params
    params.require(:story).permit(:title, :description)
  end

  def set_story
    @story = Story.find(params[:id])
  end
end
