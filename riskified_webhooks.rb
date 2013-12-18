class RiskifiedWebhooks < Sinatra::Base
  helpers Sinatra::JSON
  set :logging, true
  set :dump_errors, true
  set :protection, :except => [:http_origin]

  helpers do
    def riskified_headers
      riskified_heads = {}
      env.each_pair do |header_name, header_value|
        if header_name.downcase.include?("http_x_riskified_")
          riskified_heads[header_name] = header_value
        end
      end
      riskified_heads
    end
  end

  get "/healthcheck" do
    status 200
  end

  ["/webhooks/order_created", "/webhooks/order_submit", "/webhooks/merchant_order_created", "/webhooks/app_uninstalled"].each do |webhook|
    post webhook do
      req_params = params

      Queue.enq({params: req_params, headers: riskified_headers})
    
      return_hash = {"order" => 0, "status" => 'processing'}
      response.status = 200
      json return_hash.to_json
    end
  end
end
