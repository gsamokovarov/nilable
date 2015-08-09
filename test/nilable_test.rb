require 'test_helper'

class NilableTest < BaseTest
  test "#value returns the current wrapped value" do
    assert_equal Nilable(42).value, 42
  end

  test "returns Nilable objects on nil calls" do
    assert_nil Nilable(nil).no_such_method.value
  end

  test "delegates calls to the returned objects on non-nil calls" do
    assert_equal 43, Nilable(42).succ.value
  end

  test "delegates blocks to the wrapped object" do
    assert_equal [2, 3, 4], Nilable([1, 2, 3]).map(&:succ).value
  end

  test "can chain indefinitely" do
    assert_equal 47, Nilable(42).succ.succ.succ.succ.succ.value
  end

  test "raises exceptions caused by the wrapped object" do
    assert_raises ZeroDivisionError do
      Nilable(42) / 0
    end
  end

  test "unwraps nested Nilable value object" do
    assert_equal 'foo', Nilable(Nilable(Nilable('oof'))).reverse.value
  end
end
