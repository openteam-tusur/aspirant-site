module Searcher
  class PeopleSearcher < SearcherCarcas
    private

    def search
      Person.search do
        fulltext search_params.q if search_params.q
      end
    end
  end
end
