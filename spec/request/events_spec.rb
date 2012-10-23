require "spec_helper"

# be do
#   ensure_reachable!(server)
# end

# describe "Events" do
#   it "gets events and checks id" do
#     get '/events.json'
#     response.status.should be(200)
#     ap json_response.first
#     json_response.each { |e| e.should have_key 'id' }
#   end
# end

describe "Diagnostic" do
  it "checks Ziggo Network" do
    host = 'http://look2ws.iss.test:8280'
    ip_addr = '127.0.0.1'
    hash = md5 "WiFi##{ip_addr}#XTTC"
  
    headers 'Accept' => "application/json"

    use_server host do
      get "/ziggoIPCheck", {'c_id' => hash}
    end

    ap last_request.to_hash

    ap json_response
    response.status.should be(200)
    
  end
end
