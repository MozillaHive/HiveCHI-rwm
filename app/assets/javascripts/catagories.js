var Results = angular.module('FieldSearch', ['ngAnimate', 'anguFixedHeaderTable']);

Results.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $http.get('../../resource_files/scc.json')
    .success(function(response) {
        $scope.rules = response;
    });
}]);

Results.controller('DetailsCtrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
    $http.get('../../resource_files/scc.json')
    .success(function(response) {
        $scope.rules = response;
        $scope.whichItem = $routeParams.itemId;
});