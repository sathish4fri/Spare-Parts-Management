'use strict';
/**
 * @ngdoc function
 * @name .controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the 
 */
angular.module('sbAdminApp')
  .controller('itemCtrl', function($scope,$position, $filter, Data) {
  	  $scope.item = {};
    Data.get('itemlist').then(function(data){
        $scope.items = data.data;
    }); 

   

  });
