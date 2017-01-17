module Puppet::Parser::Functions
  newfunction(:check_url, :type => :rvalue) do |args|
    require 'net/http'

    args.all? do |url|
      begin
        response = Net::HTTP.get_response(URI(url))
        case response.code.to_i
          when 200..299
            true
          when 302
            true
          else
            Puppet.debug "URL #{url} failed with code #{response.code}"
            false
          end
      rescue
        Puppet.debug "URL #{url} failed with error #{$!}"
        false
      end
    end
  end
end

