class LinksController < ApplicationController
    def index
        # @links = Link.all
        # @links = Link.ordered(created_at: :desc)
        @links = Link.recent_first
    end

    def create
        @link = Link.new(link_params)
        if @link.save
            redirect_to root_path, notice: ""
        else
            index
            # or 
            # @links = Link.recent_first
            render :index, status: :unprocessable_entity
        end
    end

    private
    def link_params
        params.require(:link).permit(:url)
    end
end