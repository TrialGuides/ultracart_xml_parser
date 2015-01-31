module UltraCartXMLParser
  class ExtendedDetail
    FIELDS = { 
      extended_detail_name: :string,
      extended_detail_value: :string
    }

    include FieldMapper

    def initialize(extended_detail)
      @element = extended_detail
    end
  end
end
