require "test_helper"

class LinksTest < ActionDispatch::IntegrationTest

  test "Links index" do
    get links_path
    assert_response :ok
  end

  test "Links index pagination" do
    50.times { Link.create(url: "example.org") }
    get links_path(page: 2)
    # get links_path
    assert_response :ok
    # assert_select "span", "‹ Prev"
  end

  test "Links index handles pagination overflow" do
    Link.destroy_all
    get links_path(page: 2)
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "Links show" do
    get links_path(links(:anonymous))
    assert_response :ok
  end

  test "creat link requires a url" do
    post links_path, params: { link: {url: ''}}
    assert_response :unprocessable_entity
  end

  test "creat link as guest" do
    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: {url: 'https:google.com'}}
      assert_response :ok
      assert_nil Link.last.user_id
    end
  end

  test "creat link as guest without turbo" do
    assert_difference "Link.count" do
      post links_path, params: { link: {url: 'https:google.com'}}
      assert_response :redirect
      assert_nil Link.last.user_id
    end
  end

  test "creat link as user" do
    user = users(:one)
    sign_in user
    assert_difference "Link.count" do
      post links_path(format: :turbo_stream), params: { link: {url: 'https:google.com'}}
      assert_response :ok
      assert_equal user.id, Link.last.user_id
    end
  end

  test "cannot edit user's link as guest" do
    get edit_link_path(links(:one))
    assert_response :redirect
  end

  test "can edit user's link as anonymous" do
    get edit_link_path(links(:anonymous))
    assert_response :redirect
  end

  test "can edit user's link as owner" do
    user = users(:one)
    sign_in user
    get edit_link_path(links(:one))
    assert_response :ok
  end

  test "Cannot edit another user's link" do
    # user = users(:one)
    sign_in users(:one)
    get edit_link_path(links(:two))
    assert_response :redirect
  end

  test "user can not edit anonymous link" do
    user = users(:one)
    sign_in user
    get edit_link_path(links(:anonymous))
    assert_response :redirect
  end
end
