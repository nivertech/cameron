# -*- encoding: utf-8 -*-

# Diagnostic is a fake process used to test stuffs.
#
Rack::API.app do
  prefix     "diagnostic"
  respond_to :json
  
  version "v0.0.1" do
    post "/start" do
      body = request.body.read
      payload = JSON.parse(body)
      
      puts "[Request] #{payload}"
      
      {
        process:  "diagnostic",
        name:     "whois",
        
        data:     { customer_id:           payload["key"],
                    customer_name:         "Leandro Silva",
                    customer_login:        "leandrosilva.codezone",
                    customer_web_info:     { blog:    "http://leandrosilva.com.br",
                                             twitter: "codezone" },
                    customer_billing_info: { prefered_payment_method: "creditcard",
                                             prefered_due_date:       "on 5 of each month" }},
        next_activities:
          {
            parallelizable: "yes",
          
            definitions:
              [
                { name: "cloud_zabbix",
                  url:  "http://localhost:9292/diagnostic/activity/cloud/zabbix" },
                { name: "cloud_product",
                  url:  "http://localhost:9292/diagnostic/activity/cloud/product" },
                { name: "hosting_zabbix",
                  url:  "http://localhost:9292/diagnostic/activity/hosting/zabbix" },
                { name: "hosting_product",
                  url:  "http://localhost:9292/diagnostic/activity/hosting/product" },
                { name: "sqlserver_zabbix",
                  url:  "http://localhost:9292/diagnostic/activity/sqlserver/zabbix" }
              ]
          }
      }
    end
    
    post "/activity/cloud/zabbix" do
      {
        process:  "diagnostic",
        name:     "diagnostic_cloud_zabbix",

        data: { cluster_info: "up and running without any problem",
                server_info:  { ip:           "192.02.12.10.12",
                                vlan:         "vl001",
                                last_stop_at: "01/02/2011" }},
        next_activities: []
      }
    end
    
    post "/activity/cloud/product" do
      {
        process:  "diagnostic",
        name:     "diagnostic_cloud_product",

        data: { plan:   "linux pro - debian",
                status: "delivered"},
        next_activities: []
      }
    end

    post "/activity/hosting/zabbix" do
      {
        process:  "diagnostic",
        name:     "diagnostic_hosting_zabbix",

        data: { cluster_info: "up and running without any problem",
                server_info:  { ip:           "192.01.12.03.11",
                                vlan:         "vl002",
                                last_stop_at: "01/05/2011" }},
        next_activities: []
      }
    end

    post "/activity/hosting/product" do
      {
        process:  "diagnostic",
        name:     "diagnostic_hosting_product",

        data: { plan:   "pro windows",
                status: "delivered"},
        next_activities: []
      }
    end

    post "/activity/sqlserver/zabbix" do
      {
        process:  "diagnostic",
        name:     "diagnostic_sqlserver_zabbix",

        data: { cluster_info: "up and running without any problem",
                server_info:  { ip:           "192.11.14.11.02",
                                vlan:         "vl002",
                                last_stop_at: "01/04/2011" }},
        next_activities: []
      }
    end
  end
end
