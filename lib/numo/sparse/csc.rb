require 'numo/sparse/base'

module numo
	module sparse
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