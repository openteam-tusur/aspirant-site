angular
  .module('dashboard', ['ui.router', 'templates'])
  .config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard', {
        url: '/dashboard'
        templateUrl: 'dashboard.html'
        controller: 'DashboardController'
        resolve: {}
        })

    $urlRouterProvider.otherwise 'dashboard'
    ])
