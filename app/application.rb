require 'pry'

class Application
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
  
    if req.path.match(/items/) != nil
      search_param = req.path.split("/items/").last
      item = Item.all.select { |item| item.name == search_param}
      #binding.pry
      if item.count > 0 
        resp.write item.first.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    
    #binding.pry
    
    resp.finish
  end


  
end