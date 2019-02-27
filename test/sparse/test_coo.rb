class TestSparseCOO < Test::Unit::TestCase
  sub_test_case(".new") do
    sub_test_case("with shape and dtype class") do
      test("normal case") do
        coo = Numo::Sparse::COO.new([2, 3, 4], Numo::DFloat)

        assert_equal([2, 3, 4],
                     coo.shape)
        assert_equal(3,
                     coo.ndim)
        assert_equal(0,
                     coo.nnz)
      end

      test("with invalid shape") do
        assert_raise_kind_of(ArgumentError) do
          Numo::Sparse::COO.new([-1], Numo::DFloat)
        end
      end

      test("with invalid dtype") do
        assert_raise_kind_of(ArgumentError) do
          Numo::Sparse::COO.new([2, 3], String)
        end
      end
    end

    sub_test_case("with Numo::NArray object") do
      test("with 3D array") do
        nary = Numo::DFloat[[[1,  2,  0, 0], [ 0, 3,  0, 4], [ 5, 0,  0, 6]],
                            [[0, -1, -2, 0], [-3, 0, -4, 0], [-5, 0, -6, 0]]]
        coo = Numo::Sparse::COO.new(nary)

        assert_equal([2, 3, 4],
                     coo.shape)
        assert_equal(3,
                     coo.ndim)
        assert_equal(12,
                     coo.nnz)
      end
    end
  end
end
