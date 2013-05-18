translationTypesetting = angular.module "translationTypesetting", [
  "ngSanitize"
]


translationTypesetting.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

translationTypesetting.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/page.html"
    controller: "PageCtrl"

translationTypesetting.controller "PageCtrl", ($scope) ->
  $.get "/pages", (pages) ->
    $scope.pages = pages
    $scope.$apply()

translationTypesetting.filter "nl2br", ->
  (content) ->
    return unless content
    content.replace /\n/g, "<br>"
