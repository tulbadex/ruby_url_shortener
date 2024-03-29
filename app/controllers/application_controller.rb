class ApplicationController < ActionController::Base
    include Pagy::Backend

    rescue_from Pagy::OverflowError do
        redirect_to root_path
    end
    
    private
    def set_link
        # @link = Link.find(Base62.decode(params[:id]))
        # @link = Link.find(params[:id])
        @link = Link.find_by_short_code(params[:id])
    end
end
