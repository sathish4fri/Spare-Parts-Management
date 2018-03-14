<?php
require '.././libs/Slim/Slim.php';
require_once 'dbHelper.php';

\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();
$app = \Slim\Slim::getInstance();
$db = new dbHelper();

/**
 * Database Helper Function templates
 */
/*
select(table name, where clause as associative array)
insert(table name, data as associative array, mandatory column names as array)
update(table name, column names as associative array, where clause as associative array, required columns as array)
delete(table name, where clause as array)
*/


$app->get('/itemlist', function() { 
    global $db;
    $rows = $db->select("items","item_id,item_name",array("status"=>1));
    echoResponse(200, $rows);
});

$app->get('/arealist', function() { 
    global $db;
    $rows = $db->select("area","id,area_name",array("status"=>1,"is_delete"=>0));
    echoResponse(200, $rows);
});

$app->get('/employeelist', function() { 
    global $db;
    $rows = $db->select("employee","eid,emp_firstname,emp_lastname,designation,emp_id",array("status"=>1,"is_delete"=>0));
    echoResponse(200, $rows);
});

//issue list
$app->get('/issuedlist', function() { 
    global $db;
    $q = "select IT.item_id,IT.item_name,IL.id,IL.quantity,IL.ticket_no,EM.eid,EM.emp_firstname,
          EM.emp_lastname,EM.designation,EM.emp_id from issue_list IL join employee EM on  
          IL.emp_id = EM.eid join items IT on IT.item_id = IL.item_id where IL.is_delete = '0'";
    $rows = $db->executeQuery($q);
    echoResponse(200, $rows);
});

$app->get('/purchaselist', function() { 
    global $db;
    $q = "select IT.item_id,IT.item_name,PU.pur_id,PU.vendor,PU.specification,PU.quantity,PU.warranty_period,
          PU.invoice_no,PU.serial_no from purchase PU join items IT on IT.item_id = PU.item_id 
          where PU.is_delete = '0'";
    $rows = $db->executeQuery($q);
    echoResponse(200, $rows);
});

$app->post('/savePurchase', function() use ($app) { 
    $data = json_decode($app->request->getBody());
    $mandatory = array('item_id','vendor','quantity','invoice_no','serial_no');
    global $db;
    $rows = $db->insert("purchase", $data, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Purchase added successfully.";
    echoResponse(200, $rows);
});

$app->post('/updatePurchase', function() use ($app) { 
    $data = json_decode($app->request->getBody());
    $mandatory = array('pur_id','item_id','vendor','quantity','invoice_no','serial_no');
    if($data->pur_id){
        $where = array('pur_id'=>$data->pur_id);
        global $db;
        $rows = $db->update("purchase", $data, $where, $mandatory);
        if($rows["status"]=="success")
            $rows["message"] = "Purchase updated successfully.";
    }else{
        $rows["status"] = "failure";
        $rows["message"] = "Purchase id missing.";
    }
    echoResponse(200, $rows);
});

$app->post('/saveIssued', function() use ($app) { 
    $data = json_decode($app->request->getBody());
    $mandatory = array('item_id','ticket_no','quantity','emp_id');
    global $db;
    $rows = $db->insert("issue_list", $data, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Product issued successfully.";
    echoResponse(200, $rows);
});

$app->post('/updateIssued', function() use ($app) { 
    $data = json_decode($app->request->getBody());
    $mandatory = array('item_id','ticket_no','quantity','emp_id');
    if($data->id){
        $where = array('id'=>$data->id);
        global $db;
        $rows = $db->update("issue_list", $data, $where, $mandatory);
        if($rows["status"]=="success")
            $rows["message"] = "Issue list updated successfully.";
    }else{
        $rows["status"] = "failure";
        $rows["message"] = "Issuing id missing.";
    }
    echoResponse(200, $rows);
});

$app->post('/saveitemlist', function() use ($app) { 
   $data = json_decode($app->request->getBody());
    $mandatory = array('item_name');
    global $db;
    $rows = $db->insert("items", $data, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Item added successfully.";
    echoResponse(200, $rows);
});

$app->post('/updateitemlist', function() use ($app) { 
   $data = json_decode($app->request->getBody());
    $mandatory = array('item_name');
    if($data->item_id){
        $where = array('item_id'=>$data->item_id);
        global $db;
        $rows = $db->update("items", $data, $where, $mandatory);
        if($rows["status"]=="success")
            $rows["message"] = "Item added successfully.";
    }else{
        $rows["status"] = "failure";
        $rows["message"] = "Item id missing.";
    }
    echoResponse(200, $rows);
});

$app->post('/deletereq', function() use ($app) { 
   $data = json_decode($app->request->getBody());
   $mandatory = array();
   $delete_mod_id = array('area'=>'id',
                          'employee'=>'eid',
                          'issue_list'=>'id',
                          'items'=>'item_id',
                          'purchase'=>'pur_id',
                          'reorder'=>'id'
                        );
    if($data->del_id && $data->module){
        $delete = array('is_delete'=>'1');
        $where = array($delete_mod_id[$data->module]=>$data->del_id);
        global $db;
        $rows = $db->update($data->module, $delete, $where, $mandatory);
        if($rows["status"]=="success")
            $rows["message"] = "Record deleted successfully.";
    }else{
        $rows["status"] = "failure";
        $rows["message"] = "Delete id missing.";
    }
    echoResponse(200, $rows);
});

$app->post('/login', function() use ($app){ 
      $data = json_decode($app->request->getBody());
    global $db;
    $condition = array('name'=>$data->username);
    $rows = $db->select("customers_auth","name,uid", $condition);
    echoResponse(200, $rows);
});

function echoResponse($status_code, $response) {
    global $app;
    $app->status($status_code);
    $app->contentType('application/json');
    echo json_encode($response,JSON_NUMERIC_CHECK);
}

$app->run();
?>