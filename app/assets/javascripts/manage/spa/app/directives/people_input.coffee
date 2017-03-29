angular.module('dashboard')
  .directive('peopleInput', ['$http', 'localization', 'science',
    ($http, localization, science) ->
      return {
        scope:
          context: '=context'
          people:  '=people'
          person:  '=person'
          askPost: '@askPost'
          kind:    '@kind'
          specialities: '=specialities'
          blockNameValue: '=blockNameValue'
          editForm: '=editForm'
        transclude: true
        restrict: 'E'
        templateUrl: 'people_input.html'
        controller: ($scope, localization) ->
          $scope.l = localization.l
          $scope.science_dictionaries = science

          $scope.isLoading = () ->
            return $http.pendingRequests.length > 0

          for key in ['new_person', 'science']
            $scope[key] = {}

          $scope.setPerson = (obj) ->
            unless obj.originalObject.id
              $scope.personNotFound = true
              $scope.peopleInput.$setPristine()
            else
              $scope.new_person = obj.originalObject

          $scope.compareDictionariesValues = (normalize_string, dictionary_object) ->
            current_object = dictionary_object.find (obj) ->
                               obj.value == normalize_string
            return current_object

          $scope.normalizeDictionariesValue = (string, dictionary_objects) ->
            normalize_result = string.charAt(0).toUpperCase() + string.slice(1) if string
            return normalize_result

          $scope.fillPerson = (person) ->
            u = $scope.new_person
            for key in ['patronymic', 'surname', 'name']
              u[key] = person[key]
            u.url = "https://directory.tusur.ru/people/#{person.id}"

            # Result object of scence degree
            science_degree_object = $scope.compareDictionariesValues($scope.normalizeDictionariesValue(person.academic_degree),
                                                                     $scope.science_dictionaries.science_degrees)
            # Result object of scence title
            science_title_object = $scope.compareDictionariesValues($scope.normalizeDictionariesValue(person.academic_rank),
                                                                     $scope.science_dictionaries.science_titles)

            if science_degree_object
              u.science_degree = science_degree_object.value
              u.science_degree_abbr = science_degree_object.abbr

            if science_title_object
              u.science_title = science_title_object.value
              u.science_title_abbr = science_title_object.abbr

            if person.main_post
              u.work_post    = person.main_post.short_title || ''
              u.work_place   = person.main_post.subdivision.title + ' ТУСУР'
              u.post ||= {}
              u.post.title ||= {}

            $scope.updateDirectorySearch()

          $scope.cleanPerson = () ->
            $scope.new_person_post_speciality = null
            $scope.$broadcast 'cleanPerson'
            $scope.peopleInput.$setPristine() if $scope.peopleInput

          $scope.submitPerson = () ->
            if $scope.peopleInput && $scope.peopleInput.$invalid
              $scope.peopleInput.$setSubmitted()
              for _, input of $scope.peopleInput
                if input && input.$name
                  input.$setDirty()
            else
              params = {}
              angular.copy $scope.context, params
              params['person'] = $scope.new_person
              $http
                .post '/manage/people', params
                .success (data) ->
                  if $scope.people
                    $scope.people.push data
                    $scope.directory_search = null
                  else
                    $scope.person = data
                  $scope.cleanPerson()
                  $scope.hideForm()

          $scope.directorySearchTrigger = () ->
            $scope.directorySearch = !$scope.directorySearch

          $scope.updateDirectorySearch = () ->
            query = []
            for key in ['name', 'surname', 'patronymic']
              query.push $scope.new_person[key]
            query = query.join(' ')

            $scope.directorySearchTrigger()
            $http
              .get '/manage/people/directory_search', params: { term: query }
              .success (data) ->
                $scope.directorySearchTrigger()
                $scope.directory_search = data

          $scope.postsOf = (result) ->
            result.split(';')

          $scope.hideForm = () ->
            $scope.personNotFound = false
            $scope.directory_search = null

          $scope.hideNamedBlock = () ->
            $scope.blockNameValue = null

          $scope.requestFormatter = (str) ->
            q: str, ids: ($scope.people || []).map((p) -> p.id )        # ||[] decision is for one person case

          $scope.searchResponseFormatter = (data) ->
            results = []
            for result in data.people
              results.push result
            empty_object = {
              fullname: $scope.l('person.create_new')
              id: false
            }
            results.push empty_object
            return results

          $scope.setSpeciality = (speciality, callback) ->
            unless speciality.id              #create new speciality from form
              params = { speciality }
              $http
                .post 'manage/council_specialities', params
                .success (data) -> $scope.reallySetSpeciality(data, callback)
            else                              #set speciality id to person post
              $scope.reallySetSpeciality(speciality, callback)

          $scope.reallySetSpeciality = (speciality, callback) ->
            $scope.new_person.post ||= {}
            $scope.new_person.post.council_speciality_id = speciality.id
            $scope.new_person_post_speciality = speciality
            callback()

          $scope.destroySpeciality = () ->
            $scope.new_person.post.council_speciality_id = null
            $scope.new_person_post_speciality = null
      }
    ])
