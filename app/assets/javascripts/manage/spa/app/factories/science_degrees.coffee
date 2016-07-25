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
          callback()

      return f
    ])
