translationTypesetting = angular.module "translationTypesetting", [
  "ngSanitize"
]


translationTypesetting.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

translationTypesetting.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/page.html"
    controller: "PageCtrl"

  $routeProvider.when "/admin",
    templateUrl: "/views/admin.html"
    controller: "AdminCtrl"

translationTypesetting.controller "PageCtrl", ($scope) ->
  $.get "/pages", (pages) ->
    $scope.pages = pages
    $scope.$apply()

translationTypesetting.controller "AdminCtrl", ($scope) ->
  $.get "/pages", (pages) ->
    $scope.page = pages["ru"]
    $scope.$apply()

  $scope.save = (page) ->
     deffered = $.ajax
        type: "POST",
        url: "/pages",
        dataType: "json",
        data: content: page
        statusCode:
          200: ->
            window.location.href = "/#!/"

translationTypesetting.filter "nl2br", ->
  (content) ->
    return unless content
    content.replace /\n/g, "<br>"
