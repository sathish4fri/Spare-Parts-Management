'use strict';
/**
 * @ngdoc function
 * @name .controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the 
 */
angular.module('sbAdminApp')
  .controller('productsCtrl', function($scope,$position, $filter, Data ,$timeout) {
  	$scope.product = {};
    function getProduct(){
        Data.get('purchaselist').then(function(data){
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
                    {text:"Specification",predicate:"specification",sortable:true},
                    {text:"Quantity",predicate:"quantity",sortable:true},
                     {text:"Vendor",predicate:"vendor",sortable:true},
                    {text:"Serial No",predicate:"serialno",reverse:true,sortable:true,dataType:"number"},
                    {text:"Invoice No",predicate:"invoiceno",sortable:true},
                    {text:"Warranty Period",predicate:"warrantyperiod",sortable:true},
                    //{text:"Updated By",predicate:"updatedby",sortable:false},
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
      var val = product.item_id;
      product.item_id = val.item_id;

       Data.post('savePurchase', product).then(function (result) {
                    if(result.status != 'error'){
                       $scope.msg ="Record added successfully";
                       $scope.hideMsg();
                        getProduct();                 
                      $("#addproduct .close").click();
                    }else{
                        console.log(result);
                    }
                });


    };

  });
