class Fluent::HTTPOutput < Fluent::Output
  Fluent::Plugin.register_output('alertmanager', self)

  def initialize
    super
    require 'net/http'
    require 'uri'
    require 'yajl'
  end

  # Endpoint URL ex. http://alertmanager-domain/api/v1/alerts
  config_param :endpoint_url, :string

  def configure(_)
    super
    @uri = URI.parse(@endpoint_url)
  end

  def start
    super
  end

  def shutdown
    super
  end

  def create_request(record)
    req = Net::HTTP::Post.new(@uri.path)
    req.body = Yajl.dump([record])
    req['Content-Type'] = 'application/json'
    return req
  end

  def send_request(req)
    res = nil
    begin
      res = Net::HTTP.start(@uri.host, @uri.port) {|http| http.request(req) }
    rescue => e
      $log.error "Net::HTTP::Post raises exception: #{e.class}, '#{e.message}'"
    else
      unless res and res.is_a?(Net::HTTPSuccess)
        res_summary = if res
                        "#{res.code} #{res.message} #{res.body}"
                      else
                        "res=nil"
                      end
        $log.error "failed to #{req.method} #{@uri} (#{res_summary})"
      end
    end
  end

  def send_alert(record)
    send_request(create_request(record))
  end

  def emit(_, es, chain)
    es.each do |_, record|
      send_alert(record)
    end
    chain.next
  end
end
