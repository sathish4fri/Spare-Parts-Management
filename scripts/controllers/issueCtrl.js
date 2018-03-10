'use strict';
/**
 * @ngdoc function
 * @name .controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the 
 */
angular.module('sbAdminApp')
  .controller('issueCtrl', function($scope,$position, $filter, Data ,$timeout) {
  	$scope.product = {};
    function getProduct(){
        Data.get('products').then(function(data){
        $scope.products = data.data;
        }); 
      }
    getProduct();

     Data.get('itemlist').then(function(data){
        $scope.items = data.data;
    }); 

     $scope.columns = [
                    {text:"ID",predicate:"id",sortable:true,dataType:"number"},
                    {text:"Name",predicate:"name",sortable:true},
                    {text:"Quantity",predicate:"quantity",sortable:true},
                    {text:"Ticket No",predicate:"serialno",reverse:true,sortable:true,dataType:"number"},                    
                    {text:"Issued to IT engineer",predicate:"warrantyperiod",sortable:true},
					{text:"Action",predicate:"",sortable:false}
                ];

    $scope.deleteProduct = function(product){
        if(confirm("Are you sure to remove the product")){
            Data.delete("products/"+product.id).then(function(result){
              $scope.msg ="delete successfully";
              $scope.hideMsg();
                 getProduct();
            });
        }
    };

     $scope.hideMsg = function(){
       $timeout(function(){
          $scope.msg = "";
       },1000)
     }

    $scope.saveProduct = function(product){
      console.log(product);
      var val = product.name;
      product.name = val.name;

       Data.post('products', product).then(function (result) {
                    if(result.status != 'error'){
                        getProduct();                 
                      $("#addproduct .close").click();
                    }else{
                        console.log(result);
                    }
                });


    };

  });