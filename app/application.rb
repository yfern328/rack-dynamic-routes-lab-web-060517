class Application

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_in_question = req.path.split("/items/").last
      finder = Item.all.find{ |item| item.name == item_in_question }
      if finder
        resp.write finder.price.to_s
        resp.status = 200
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
