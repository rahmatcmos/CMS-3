﻿angular.module('board',['resource.articles'])

.config(["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when "/board",
      templateUrl: "/app/board/board.tpl.html"
      controller: 'BoardCtrl'
      title: 'Message Boards'
      resolve:
        messages: ['$q','Message',($q,Message)->
          deferred = $q.defer()
          debugger
          Message.queryOnce 
            $filter:'IsDeleted eq false'
          , (data) ->
            deferred.resolve data.value
          deferred.promise
        ]
])

.controller('BoardCtrl',
["$scope","$translate","messages" ,"messager", "context"
($scope, $translate, messages, messager, context) ->
  $scope.entity=
    Author:context.account.name
    Email:context.account.email
    Url:context.account.url
  $scope.editmode = !context.account.name
  $scope.isAdmin = context.auth.admin

  $scope.list = messages

  $scope.save = () ->
    $scope.submitted=true
    if $scope.form.$invalid
      return

    $scope.loading = $translate("global.post")
    $scope.entity.BoardId=UUID.generate()
    Message.save $scope.entity
    ,(data)->
      $scope.list.unshift(data)
      $scope.entity.Content=""
      $scope.submitted=false
      $scope.loading = ""
      context.account =
        name: $scope.entity.Author
        email: $scope.entity.Email
        url: $scope.entity.Url
    ,(error)->
      $scope.submitted=false
      $scope.loading = ""

  $scope.remove = (item) ->
    messager.confirm ->
      Message.remove id:"(guid'#{item.BoardId}')",->
        item.IsDeleted=true
        messager.success "Message has been removed."
])