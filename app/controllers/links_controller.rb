class LinksController < ApplicationController
    before_action :set_link, only: [:show, :edit, :update, :destroy]
    before_action :check_if_editable, only: [:edit, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do
        redirect_to root_path, alert: "Missing link"
    end
    
    def index
        # @links = Link.all
        # @links = Link.ordered(created_at: :desc)
        @links = Link.recent_first
        @link ||= Link.new
    end

    def show
    end

    def create
        @link = Link.new(link_params.with_defaults(user: current_user))
        # @link.user = current_user
        if @link.save
            # redirect_to root_path, notice: "Link successfully created"
            respond_to do |format|
                format.html { redirect_to root_path, notice: "Link successfully created" }
                format.turbo_stream { render turbo_stream: turbo_stream.prepend("links", @link)}
                # format.turbo_stream { render turbo_stream: [
                #     turbo_stream.prepend("links", @link),
                #     turbo_stream.replace("link_form", partial: "links/form", locals: {link: Link.new})
                # ] }
            end
        else
            index
            # or 
            # @links = Link.recent_first
            render :index, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @link.update(link_params)
            redirect_to @link, notice: "Link has been successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @link.destroy
        redirect_to root_path, notice: "Link has been successfully deleted"
    end

    private
    def link_params
        params.require(:link).permit(:url)
    end

    def check_if_editable
        # unless !@link.editable_by?(current_user)
        #     redirect_to @link, alert: "You don't have permission to do that"
        # end
        redirect_to @link, alert: "You don't have permission to do that" unless @link.editable_by?(current_user)
    end
end