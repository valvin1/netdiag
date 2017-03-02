require_relative '../netdiag-config'
module Netdiag
  class DNS
    def initialize
      @dns = Resolv::DNS.new
      @config = NetdiagConfig.new
    end
    def diagnose
      begin
        self.resolve_ipv4(@config.getTestDns)
        self.resolve_ipv6(@config.getTestDns)
      rescue Exception => e
        @error = e.message
        return false
      end
      @error = nil
      return true
    end
  
    def resolve_ipv4(name)
      @dns.getresource(name, Resolv::DNS::Resource::IN::A)
    end
    def resolve_ipv6(name)
      @dns.getresource(name, Resolv::DNS::Resource::IN::AAAA)
    end
  
  end
end
