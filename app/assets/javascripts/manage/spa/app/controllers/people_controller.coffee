angular
  .module('dashboard')
  .controller('PeopleController', ['$scope', '$http', '$stateParams', ($scope, $http) ->
    params = $scope.$state.params
    $scope.q = params.q
    $scope.page = params.page
    $scope.activePersonForm = null

    $scope.getPeople = () ->
      params = q: $scope.q, page: $scope.page
      $http
        .get '/manage/people/search', params: params
        .success (data) ->
          for key, value of data
            $scope[key] = value
        .error ->
          console.warn 'error happened'
          $state.go 'dashboard'

    $scope.searchPeople = (set_default_page = false) ->
      $scope.page = 1 if set_default_page
      $scope.$state.go("people", {q: $scope.q, page: $scope.page}, { notify: false })
      $scope.getPeople()
      $scope.personForms = {}

    $scope.changePage = ()->
      $scope.$state.go("people", {q: $scope.q, page: $scope.page}, { notify: false })
      $scope.getPeople()

    $scope.setPersonActive = (person) ->
      $scope.activePersonForm = person.id

    $scope.savePerson = (person) ->
      unless $scope.personForm.$valid                   #show validations error
        $scope.personForm.$setSubmitted()
        for _, input of $scope.personForm
          if input && input.$name
            input.$setDirty()
      else
        params = { person: person }                     #save person
        $http
          .patch "manage/people/#{person.id}", params
          .success (data) ->
            person = data
            $scope.activePersonForm = null

    $scope.restorePerson = (person) ->
      $http.get "manage/people/#{person.id}"
           .success (data) ->
             person = data
             $scope.activePersonForm = null

    $scope.getPeople()
    ])
