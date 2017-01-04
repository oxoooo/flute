module Flute
  class SpiderBase

    def manager_network
      network
    end

    def network
      self.class.opts[:network]
    end

    def manager
      @manager
    end

    def reset_manager
      @manager = manager_network.create_manager
    end

    def items
      []
    end

    def before_parse(_items)
      _items
    end

    def init_queue(_items)
      reset_manager
      _items
    end

    def parse(_items)
      _items
    end

    def run_queue(_items)
      manager.run if manager.queued_requests.size > 0
      _items
    end

    def after_parse(_requests)
      _requests
    end

    def pipeline
      methods = self.class.opts[:middleware].map {|name| method(name)}
      _items = items
      methods.each { |middleware|
        _items = middleware.call(_items)
      }
      _items
    end


    class << self

      def opts
        @opts ||= {
          middleware: [:before_parse, :init_queue, :parse, :run_queue, :after_parse],
          network: Network.new
        }
      end

      def set_name(value)
        opts[:name] = value
      end

      def start_urls(value)
        opts[:start_urls] = value
      end

      def middleware(value)
        opts[:middleware] = value
      end

      def set_network(value)
        opts[:network] = value
      end

    end
  end
end