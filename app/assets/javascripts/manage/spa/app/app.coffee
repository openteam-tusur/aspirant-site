angular
  .module('dashboard', ['ui.router', 'templates', 'angucomplete-alt'])
  .config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard', {
        url: '/dashboard'
        templateUrl: 'dashboard.html'
        controller: 'DashboardController'
        resolve: {}
        })

      .state('council', {
        url: '/council'
        templateUrl: 'council.html'
        controller: 'CouncilController'
        resolve: {}
        })

      .state('permissions', {
        url: '/permissions'
        templateUrl: 'permissions.html'
        controller: 'PermissionsController'
        resolve: {}
        })

      .state('adverts', {
        url: '/adverts'
        templateUrl: 'adverts.html'
        controller: 'AdvertsController'
        resolve: {}
        })

    $urlRouterProvider.otherwise 'dashboard'
    ])
