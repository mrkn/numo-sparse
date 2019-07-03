class TestSparseCSC < Test::Unit::TestCase
  sub_test_case(".new") do
    sub_test_case("with shape and dtype class") do
      test("normal case") do
        csc = Numo::Sparse::CSC.new([2, 3], Numo::DFloat)

        assert_equal([2, 3],
                     csc.shape)
        assert_equal(2,
                     csc.ndim)
        assert_equal(0,
                     csc.nnz)
      end

      test("with invalid shape") do
        assert_raise_kind_of(ArgumentError) do
          Numo::Sparse::CSC.new([2, 3, 4], Numo::DFloat)
        end
      end

      test("with invalid dtype") do
        assert_raise_kind_of(ArgumentError) do
          Numo::Sparse::CSC.new([3, 3], String)
        end
      end
    end

    sub_test_case("with Numo::NArray object") do
      test("with 2D array") do
        nary = Numo::DFloat[[3, 1, 0], [0, 7, 0], [6, 0, 9]]
        csc = Numo::Sparse::CSC.new(nary)

        assert_equal([3, 3],
                     csc.shape)
        assert_equal(2,
                     csc.ndim)
        assert_equal(5,
                     csc.nnz)
      end
    end
  end
end

#Perform a set of basic tests until csr has been updated