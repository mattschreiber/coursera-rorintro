class Recipe
	include HTTParty


	def self.for term
		get("/search", query: {q: term})["recipes"]

	end
end

