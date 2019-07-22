require 'numo/sparse/base'

module Numo
  module Sparse
    class CSR < BaseTensor
      def self.max_ndim
        2
      end

      def nnz
        @data.length
      end

      private def initialize_with_narray(narray)
        @shape = check_shape(narray.shape).dup.freeze
        @dtype = narray.class
        @data = narray[narray.ne(0)]
        # TODO: index creation
      end

      private def initialize_empty(shape, dtype)
        @shape = check_shape(shape).dup.freeze
        @dtype = check_dtype(dtype)
        @data = []
      end

        private def make_csr(narray)
        row_limit, col_limit = shape[0], shape[1]
        matrix, curr_row, count = narray, 0, 0
        indices = []
        indices_temp = [] #this is for the transpose
        indptr = []
        indptr[0] = 0
        while curr_row < row_limit
          curr_col = 0
          while curr_col < col_limit
            if matrix[curr_row,curr_col] != 0
              count += 1
              indices.push(curr_col)
              indices_temp.push(curr_row)
            end
            curr_col += 1
          end
          indptr.push(count)
          curr_row += 1
        end
        @indices = Numo::Int32[*indices]
        @indices_temp = Numo::Int32[*indices_temp]
        @indptr = Numo::Int32[*indptr]
      end
    end
  end
end
