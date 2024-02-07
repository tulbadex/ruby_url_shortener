require "test_helper"

class ViewsTest < ActionDispatch::IntegrationTest

    test "Visiting a link record a view" do
        link = links(:one)
        original_views_count = link.views_count
        assert_difference 'View.count' do
            # get view_path(link)
            # assert_equal original_views_count + 1, link.reload.views_count
            assert_difference 'link.views_count' do
                get view_path(link)
                link.reload
                assert_response :redirect
                follow_redirect!
            end
        end
    end

    test "visiting a link redirects to the URL" do
        link = links(:one)
        get view_path(link)
        # assert_response :redirect
        assert_redirected_to link.url
    end

  
end
