require 'numo/sparse/base'

module Numo
  module Sparse
    class CSC < BaseTensor
      attr_reader :shape, :dtype, :data, :indptr, :indices, :data_csc, :coords
      
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
        @coords = make_coords(narray)
      end

      private def initialize_empty(shape, dtype)
        @shape = check_shape(shape).dup.freeze
        @dtype = check_dtype(dtype)
        @data = []
      end
      
      private def make_coords(narray)
        row_limit, col_limit, matrix, curr_col, count =
          shape[0], shape[1], narray, 0, 0
        indices = []
        indptr = []
        @data_csc = [] #Double check if this is correct
        indptr[0] = 0
        while curr_col < col_limit
          curr_row = 0
          while curr_row < row_limit
            if(matrix[curr_row, curr_col] != 0)
              count += 1
              indices.push(curr_row)
              @data_csc.push(matrix[curr_row, curr_col])
            end
          curr_row += 1
          end
        indptr.push(count)
        curr_col += 1
        end
      [@data_csc, indices, indptr]
      end
    end
  end
end