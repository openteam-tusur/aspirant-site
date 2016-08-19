angular
  .module('dashboard')
  .controller('EditCouncilController', ['$scope', '$http', ($scope, $http) ->

    $scope.blockName = null

    $scope.changeBlockName = (name) ->
      $scope.blockName = name

    $scope.changePersonForm = (object) ->
      $scope.personForm = object

    $scope.getCouncil = () ->
      $scope.$emit 'Load'
      id = $scope.$state.params.councilId
      $http
        .get "/manage/dissertation_councils/#{id}"
          .success (data) ->
            $scope.$emit 'Unload'
            $scope.council = data
          .error -> $scope.$state.go 'dashboard'

    $scope.setContext = () ->
      $scope.context = {
                         context_id: $scope.$state.params.councilId
                         context_type: 'DissertationCouncil'
                       }

    $scope.destroyPost = (person) ->
      params = { id: person.current_post.id }
      $http
        .delete "/manage/posts/#{person.current_post.id}"
        .success (data) ->
          if data
            $scope.removeElementFrom $scope.council.people, person

    $scope.addSpecialityToCouncil = (speciality, success_callback) ->
      params = { speciality: speciality }
      params.council_id = $scope.council.id
      $http
        .post "/manage/council_specialities", params
      .success (data) ->
        $scope.council.specialities.push data
        success_callback()

    $scope.removeSpecialityFromCouncil = (speciality) ->
      params = { council_id: $scope.council.id }
      $http
        .post "/manage/council_specialities/#{speciality.id}/remove_from_council", params
        .success (data) ->
          if data
            $scope.removeElementFrom $scope.council.specialities, speciality

    $scope.updateSpecialityOrder = (speciality, index) ->
      params = {
        council_id: $scope.council.id
        index: index
      }
      $http
        .post "/manage/council_specialities/#{speciality.id}/update_order", params

    $scope.updatePersonOrder = (person, index) ->
      params = { index: index }
      for key, value of $scope.context
        params[key] = value
      $http
        .post "/manage/people/#{person.id}/update_order", params

    $scope.savePerson = (person) ->
      unless $scope.personForm.$valid                   #show validations error
        $scope.personForm.$setSubmitted()
        for _, input of $scope.personForm
          if input && input.$name
            input.$setDirty()
      else
        params = { person: person }                     #save person
        $http
          .patch "/manage/people/#{person.id}", params
          .success (data) ->
            $scope.$broadcast 'updatePerson'


    $scope.restorePerson = (person) ->
      $http.get "/manage/people/#{person.id}"
           .success (data) ->
             person = data
             $scope.$broadcast 'deactivatedEditForm'

    $scope.initializer = ()->
      $scope.getCouncil()
      $scope.setContext()

    $scope.initializer()

  ])
