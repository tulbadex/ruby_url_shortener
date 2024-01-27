require "test_helper"

class Base62Test < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "encode 0" do
    assert_equal "0", Base62.encode(0)
  end

  test "encode 1" do
    assert_equal "1", Base62.encode(1)
  end

  test "encode 10" do
    assert_equal "a", Base62.encode(10)
  end

  test "encode 999_999" do
    assert_equal "4c91", Base62.encode(999_999)
  end

  test "encode 12345" do
    assert_equal "3d7", Base62.encode(12345)
  end

  test "encode 1024" do
    assert_equal "gw", Base62.encode(1024)
  end

  test "decode '0'" do
    assert_equal 0, Base62.decode("0")
  end

  test "decode '1'" do
    assert_equal 1, Base62.decode("1")
  end

  test "decode 'a'" do
    assert_equal 10, Base62.decode("a")
  end

  test "decode '4c91'" do
    assert_equal 999_999, Base62.decode("4c91")
  end

  test "decode '3d7'" do
    assert_equal 12345, Base62.decode("3d7")
  end

  test "decode 'gw'" do
    assert_equal 1024, Base62.decode("gw")
  end
end
