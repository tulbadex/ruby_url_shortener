class LinksController < ApplicationController
    before_action :set_link, only: [:show, :edit, :update, :destroy]

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
        @link = Link.new(link_params)
        if @link.save
            redirect_to root_path, notice: "Link successfully created"
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
end