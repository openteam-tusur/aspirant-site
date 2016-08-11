angular
  .module('dashboard')
  .controller('EditAdvertController', ['$timeout', '$scope', '$http', 'science', ($timeout, $scope, $http, science) ->
    $scope.url = '/manage/announcements/'
    $scope.science = science

    $scope.blockName = null

    $scope.changeBlockName = (name) ->
      $scope.blockName = name

    $scope.isLoading = () ->
      return $http.pendingRequests.length > 0

    $scope.changeState = (transition) ->
      $http
        .post "#{$scope.url}#{$scope.advert.id}/#{transition}"
        .success (data) ->
          $scope.$state.go 'adverts'

    $scope.resolveChangeStateVisibility = (state) ->
      return false unless $scope.advert
      state == $scope.advert.aasm_state

    $scope.getAdvert = () ->
      id = $scope.$state.params.advertId

      $http
        .get "#{$scope.url}#{id}"
        .success (data) ->
          $scope.advert = {}
          $scope.stored_advert = {}
          angular.copy data, $scope.advert
          angular.copy data, $scope.stored_advert                 #object for changes detection
          $scope.science.getScienceDictionaries $scope.callbackForScienceDegree
          $scope.getAvalaibleCouncils()
        .error -> $scope.$state.go 'dashboard'

    $scope.contextFor = (string) ->
      if $scope.advert
        $scope["#{string}_context"] = {
          context_type: 'Advert'
          context_id:   $scope.advert.id
          person_type: string
        }

    $scope.callbackForScienceDegree = (data) ->
      if $scope.advert.science_degree
        $scope.science_degree = {}
        science_degree = data.science_degrees.find (e) ->
          e.value == $scope.advert.science_degree
        angular.copy science_degree, $scope.science_degree

    $scope.updateField = (field) ->
      if $scope.fieldChanged(field)
        params = {
          id: $scope.advert.id
          advert:
            "#{field}": $scope.advert[field]
        }

        $scope.$watch($scope.isLoading, (e) ->
          if e
            $scope.showSuccessState = false
        )

        $scope.showPreloader = field
        $http
          .patch "#{$scope.url}/#{$scope.advert.id}", params
          .success (data) ->
            $scope.stored_advert[field] = data[field]
            $scope.showSuccessState = true
            $timeout ->
              $scope.showSuccessState = false
            , 2000

    $scope.fieldChanged = (field) ->
      return false unless $scope.advert && $scope.stored_advert
      $scope.advert[field] != $scope.stored_advert[field]

    $scope.addSpeciality = (speciality, callback) ->
      if speciality.id
        $scope.advert.council_speciality = speciality
        $scope.advert.council_speciality_id = speciality.id
        $scope.updateField 'council_speciality_id'
        callback() if callback
      else
        params = { speciality: speciality }
        $http
          .post "manage/council_specialities", params
          .success (data) -> $scope.addSpeciality(data, callback)

    $scope.destroySpeciality = () ->
      $scope.advert.council_speciality_id = null
      $scope.advert.council_speciality = null
      $scope.updateField 'council_speciality_id'

    $scope.destroyPost = (person, person_type) ->
      params = $scope.contextFor person_type
      $http
        .post "/manage/people/#{person.id}/remove_from_advert", params
        .success (data) ->
          if data
            obj = $scope.advert[person_type] || $scope.advert["#{person_type}s"]
            if obj.constructor == Array            #multiple model
              $scope.removeElementFrom $scope.advert["#{person_type}s"], person
            else if obj.constructor == Object
              $scope.advert[person_type] = null    #single role (mentor or applicant)

    $scope.capitalize = (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)

    $scope.submitAdvert = () ->
      params = $scope.createParams()
      $http
        .post "#{$scope.url}#{$scope.advert.id}"
        .success (data) ->
          $scope.advert = data

    $scope.getAvalaibleCouncils = () ->
      $http
        .get '/manage/dissertation_councils'
        .success (data) ->
          $scope.avalaibleCouncils = data.councils

    $scope.updateDissertationCouncil = () ->
      $scope.advert.dissertation_council_id = $scope.advert.dissertation_council.id
      $scope.updateField "dissertation_council_id"

    $scope.copyFrom = (key) ->
      $scope.advert[key] = $scope[key]['value']
      $scope.updateField key

    $scope.getSpecialities = () ->
      $http
        .get 'manage/council_specialities'
        .success (data) ->
          $scope.specialities = data

    $scope.initializer = () ->
      $scope.getAdvert()

    $scope.changePersonForm = (object) ->
      $scope.personForm = object

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
          .patch "manage/people/#{person.id}", params
          .success (data) ->
            $scope.$broadcast 'updatePerson'

    $scope.restorePerson = (person) ->
      $http.get "manage/people/#{person.id}"
           .success (data) ->
             person = data
             $scope.$broadcast 'deactivatedEditForm'

    $scope.getSpecialities()
    $scope.initializer()
    ])
