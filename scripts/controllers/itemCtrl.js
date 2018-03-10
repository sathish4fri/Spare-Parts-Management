'use strict';
/**
 * @ngdoc function
 * @name .controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the 
 */
angular.module('sbAdminApp')
  .controller('itemCtrl', function($scope,$position, $filter, Data , $timeout) {
  	  $scope.item = {};
    function getItemList(){
      Data.get('itemlist').then(function(data){
          $scope.items = data.data;
      }); 
    }
    getItemList()

      $scope.hideMsg = function(){
       $timeout(function(){
          $scope.msg = "";
       },1000)
     }
   
    $scope.saveItem = function(item){
      item.status = 1;
      console.log(item);

       Data.post('saveitemlist', item).then(function (result) {
                    if(result.status != 'error'){
                      $("#addItem .close").click();
                      $scope.msg ="Item added successfully";
                      $scope.hideMsg();
                        getItemList(); 
                    }else{
                        console.log(result);
                    }
                });
    }
  });
