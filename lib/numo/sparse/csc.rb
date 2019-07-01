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
  end
 end
end