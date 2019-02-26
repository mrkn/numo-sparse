require "numo/sparse/version"
require "numo/narray"

module Numo
  module Sparse
    class Error < StandardError; end

    class CSR
      def initialize(*args)
        case args[0]
        when Numo::NArray
          initialize_with_narray(*args)
        when Array
          initialize_empty(*args)
        else
          raise ArgumentError
        end
      end

      attr_reader :shape, :dtype

      def ndim
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

      private def check_shape(shape)
        if shape.length != 2
          raise ArgumentError, "Invalid dimension: #{shape}"
        end
        unless shape.all? {|x| x > 0 }
          raise ArgumentError, "Shape has negative values: #{shape}"
        end
        shape
      end

      private def check_dtype(dtype)
        return dtype if dtype < Numo::NArray
        raise ArgumentError, "Invalid dtype: #{dtype}"
      end
    end
  end
end
