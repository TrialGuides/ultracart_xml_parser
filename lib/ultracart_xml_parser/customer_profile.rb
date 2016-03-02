module UltraCartXMLParser
  class CustomerProfile
    FIELDS = {
      email: :string, 
      terms: :string, 
      qb_class: :string, 
      track_separately: :boolean,
      tax_exempt: :boolean
    }

    include FieldMapper

    def initialize(customer_profile)
      @element = customer_profile
    end
  end
end
