angular.module('dashboard')
  .directive('peopleInput', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          context: '=context'
          people:  '=people'
          person:  '=person'
          askPost: '@askPost'
          kind:    '@kind'
        transclude: true
        restrict: 'E'
        templateUrl: 'people_input.html'
        controller: ($scope, localization) ->
          $scope.l = localization.l

          for key in ['new_person', 'science']
            $scope[key] = {}

          $scope.setPerson = (obj) ->
            unless obj.originalObject.id
              $scope.personNotFound = true
              $scope.peopleInput.$setPristine()
            else
              $scope.new_person = obj.originalObject

          $scope.fillPerson = (person) ->
            u = $scope.new_person
            for key in ['patronymic', 'surname', 'name']
              u[key] = person[key]
            u.url = "https://directory.tusur.ru/people/#{person.id}"
            u.work_post    = person.main_post.title
            u.work_post    = person.main_post.short_title unless u.work_post.length
            u.work_place   = person.main_post.subdivision.title + ' ТУСУР'
            u.directory_id = person.id

            $scope.updateDirectorySearch()

          $scope.cleanPerson = () ->
            $scope.$broadcast 'cleanPerson'
            $scope.peopleInput.$setPristine() if $scope.peopleInput

          $scope.submitPerson = () ->
            if $scope.peopleInput && $scope.peopleInput.$invalid
              $scope.peopleInput.$setSubmitted()
              for _, input of $scope.peopleInput
                if input && input.$name
                  input.$setDirty()
            else
              params = Object.assign {}, $scope.context
              params['person'] = $scope.new_person
              $http
                .post '/manage/people', params
                .success (data) ->
                  if $scope.people
                    $scope.people.push data
                  else
                    $scope.person = data
                  $scope.cleanPerson()
                  $scope.hideForm()

          $scope.updateDirectorySearch = () ->
            query = []
            for key in ['name', 'surname', 'patronymic']
              query.push $scope.new_person[key]
            query = query.join(' ')
            $http
              .get '/manage/people/directory_search', params: { term: query }
              .success (data) ->
                $scope.directory_search = data

          $scope.postsOf = (result) ->
            result.split(';')

          $scope.hideForm = () ->
            $scope.personNotFound = false

          $scope.requestFormatter = (str) ->
            q: str, ids: ($scope.people || []).map((p) -> p.id )        # ||[] decision is for one person case

          $scope.setSpeciality = (speciality, callback) ->
            unless speciality.id
              params = { speciality }
              $http
                .post 'manage/council_specialities', params
                .success (data) ->
                  $scope.new_person.council_speciality_id = data.id
                  $scope.new_person.speciality = data
                  callback()

            $scope.new_person.council_speciality_id = speciality.id
            $scope.new_person.speciality = speciality
            callback()

          $scope.destroySpeciality = () ->
            $scope.new_person.council_speciality_id = null
            $scope.new_person.speciality = null

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
      }
    ])
