translationTypesetting = angular.module "translationTypesetting", [
  "ngResource"
]


translationTypesetting.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

translationTypesetting.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/page.html"
