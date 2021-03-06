module DatastaxRails
  # Holds a collection of DatastaxRails::Base objects.
  class Collection < Array
    # @!attribute [r] total_entries
    #   @return [Fixnum] the total number of entries that match the search
    # @!attribute [r] per_page
    #   @return [Fixnum] the per page value of the search that produced these results (used by will_paginate)
    # @!attribute [r] current_page
    #   @return [Fixnum] the current page of the search that produced these results (used by will_paginate)
    # @!attribute [r] facets
    #   @return [Hash] the facet results (field and/or range)
    attr_accessor :total_entries, :per_page, :current_page, :facets, :highlights

    def inspect
      "<DatastaxRails::Collection##{object_id} contents: #{super}>"
    end

    def total_pages
      return 1 unless per_page
      (total_entries / per_page.to_f).ceil
    end
  end
end
