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
    sub_test_case("with Numo::NArray object") do
      test("with 2D array") do
        nary = Numo::DFloat[[1, 0, 2], [0, 3, 0], [4, 0, 5]]
        csc = Numo::Sparse::CSC.new(nary)

        assert_equal([3, 3],
                     csc.shape)
        assert_equal(2,
                     csc.ndim)
        assert_equal(5,
                     csc.nnz)
      end
    end

    sub_test_case("with Numo::NArray object") do
      test("with 2D array and coords") do
        naray = Numo::DFloat[[1, 0, 4], [0, 0, 5], [2, 3, 6]]
        csc = Numo::Sparse::CSC.new(naray)
      
        assert_equal([3, 3],
                     csc.shape)
        assert_equal(2,
                     csc.ndim)
        assert_equal(6,
                     csc.nnz)
        assert_equal(Numo::DFloat[1, 2, 3, 4, 5, 6], 
                     csc.data)
        assert_equal(Numo::Int32[0, 2, 2, 0, 1, 2], 
                     csc.indices)
        assert_equal(Numo::Int32[0, 2, 3, 6], 
                     csc.indptr)
   end
  end
 end
end