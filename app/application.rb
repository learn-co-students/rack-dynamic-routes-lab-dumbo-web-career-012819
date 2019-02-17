require "pry"

class Application

	@@items = []

	def call(env)
	    resp = Rack::Response.new
	    req = Rack::Request.new(env)
	    if req.path.match(/items/) && @@items.select {|item| item.name == req.path.split("/items/").last}.to_a != []
	    	item_name = req.path.split("/items/").last
	    	item = @@items.find {|i| i.name == item_name}
	    	resp.write item.price
	    elsif !req.path.match(/items/)
	    	resp.write "Route not found"
	    	resp.status = 404
	    elsif @@items.select {|item| item.name == req.path.split("/items/").last}.to_a == []
	    	resp.write "Item not found"
	    	resp.status = 400
	    end

	    resp.finish
	end

end