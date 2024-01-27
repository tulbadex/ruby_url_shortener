class ApplicationController < ActionController::Base
    private
    def set_link
        # @link = Link.find(Base62.decode(params[:id]))
        @link = Link.find(params[:id])
    end
end
