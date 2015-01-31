module UltraCartXMLParser
  class TransactionDetail
    FIELDS = {
      transaction_id: :string, 
      transaction_gateway: :string, 
      transaction_timestamp: :datetime, 
      transaction_successful: :boolean
    }

    include FieldMapper

    def initialize(transaction_detail)
      @element = transaction_detail
    end

    def extended_details
      @element.xpath('//extended_details//extended_detail').map { |extended_detail| ExtendedDetail.new(extended_detail) }
    end
  end
end
