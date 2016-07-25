angular
  .module('dashboard')
  .factory('science', ['$http',
    ($http) ->
      f = {}

      f.getScienceDictionaries = (callback = angular.noop) ->
        f.promise ||= $http.get 'manage/angular/get_science_degrees_and_titles'
        f.promise.success (data) ->
          f.science_titles = data.science_titles
          f.science_degrees = data.science_degrees
          callback(data)

      f.getScienceTypes = (callback = angular.noop) ->
        params = class_name: 'CouncilSpeciality', enumerize_value: 'science_type'
        f.types_promise ||= $http.get "/manage/angular/get_enumerize_values", params: params
        f.types_promise.success (data) ->
          f.avalaibleScienceTypes = data.values
          callback(data)

      return f
    ])
