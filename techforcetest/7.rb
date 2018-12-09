require 'json'

module Products
  def self.sort_by_price_ascending(json_string)
    JsonProductsSorter.call(json_string)
  end

  class JsonProductsSorter
    def self.call(json_string)
      self.new(json_string).call
    end

    def initialize(json_string)
      @json_string = json_string
    end

    def call
      sorted_records.to_json
    end

    private
    def sorted_records
      records.sort_by do |record|
        [record['price'], record['name']]
      end
    end

    def records
      JSON.parse(@json_string)
    end
  end
end

#puts Products.sort_by_price_ascending('[{"name":"eggs","price":1},{"name":"coffee","price":9.99},{"name":"rice","price":4.04}]')
puts Products.sort_by_price_ascending('[{"name":"bbb","price":1},{"name":"aaa","price":1}]')
