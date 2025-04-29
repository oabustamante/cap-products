using com.training as training from '../db/training';

service ManageOrders {
    // entity GetOrders as projection on training.Orders;
    // entity CreateOrder as projection on training.Orders;
    // entity UpdateOrder as projection on training.Orders;
    // entity DeleteOrder as projection on training.Orders;

    type cancelOrderReturn {
        status  : String enum {
            Succeeded;
            Failed;
        };
        message : String
    };

    // function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
    // action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;

    entity Orders as projection on training.Orders
        actions {
            function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
            action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;
        }
}
