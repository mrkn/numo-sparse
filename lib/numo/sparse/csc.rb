require 'numo/sparse/base'

module Numo
 module Sparse
  class CSC < BaseTensor
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
	#insert the ability to create one just by finding the transpose of a CSR matrix
	
   end
  end
 end