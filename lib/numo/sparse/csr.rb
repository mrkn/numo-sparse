require 'numo/sparse/base'

module Numo
  module Sparse
    class CSR < BaseTensor
      attr_reader :shape, :dtype, :data, :indptr, :indices, :indices_temp

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
        make_csr(narray)
      end

      private def initialize_empty(shape, dtype)
        @shape = check_shape(shape).dup.freeze
        @dtype = check_dtype(dtype)
        @data = []
      end

      # Creates the sparse matrix in csr format
      # @param narray [narray] the matrix that will be converted
      # @return [CSR] all values/array's assigned
      # @example
      #   narray = Numo::DFloat[[1, 0, 2], [0, 0, 3], [4, 5, 6]]
      #   csr = Numo::Sparse::CSR.new(narray)
      #   csr.indices
      #   # => [0, 2, 2, 0, 1, 2]
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

      # Converts the sparse matrix into a normal array
      # @return [narray] the matrix from CSR
      # @example
      #   narray = Numo::DFloat[[1, 0, 2], [0, 0, 3], [4, 5, 6]]
      #   csr = Numo::Sparse::CSR.new(narray)
      #   csr.to_narray
      #   # => Numo::DFloat[[1, 0, 2], [0, 0, 3], [4, 5, 6]]
      def to_narray
        narray = data.class.zeros(shape)
        row, row_lim, curr_ind = 0, 0, 0
        curr_data, current, curr_ptr = 0, 0, 1
        while row < indptr.size - 1
          row_lim = indptr[curr_ptr] - indptr[curr_ptr-1]
          while current < row_lim
            narray[row, indices[curr_ind]] = data[curr_data]
            curr_ind += 1
            curr_data += 1
            current += 1
          end
          curr_ptr += 1
          row += 1
          current = 0
        end
        narray
      end
    end
  end
end
