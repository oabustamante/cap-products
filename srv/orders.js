const { error } = require("@sap/cds");
const cds = require("@sap/cds");
const { Orders } = cds.entities("com.training");

module.exports = (srv) => {
    // srv.exports("*", (req) => {
    //     console.log(`Method: ${req.method}`);
    //     console.log(`Target: ${req.target}`);
    // });
    // ** READ **
    srv.on("READ", "Orders", async (req) => {    // GetOrders -> Orders
        if (req.data.ClientEmail !== undefined) {
            return await SELECT.from`com.training.Orders`.where`ClientEmail = ${req.data.ClientEmail}`;
        }
        return await SELECT.from(Orders);
    });

    srv.after("READ", "Orders", (data) => {  // GetOrders => Orders
        return data.map((order) => (order.Reviewed = true));
    });

    // ** CREATE **
    srv.on("CREATE", "Orders", async (req) => {    // CreateOrder -> Orders
        let returnData = await cds.transaction(req)
            .run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreatedOn: req.data.CreatedOn,
                    Reviewed: req.data.Reviewed,
                    Approved: req.data.Approved
                })
            ).then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.error(409, "Record Not Inserted");
                }
            }).catch((err) => {
                console.log(err);
                req.error(error.code, err.message);
            });
        console.log("Before end", returnData);
        return returnData;
    });

    // -- BEFORE --
    srv.before("CREATE", "Orders", (req) => {      // CreateOrder -> Orders
        req.data.CreatedOn = new Date().toISOString().slice(0, 10);
        return req;
    });

    // ** UPDATE **
    srv.on("UPDATE", "Orders", async (req) => {    // UpdateOrder -> Orders
        let returnData = await cds.transaction(req).run([
            UPDATE(Orders, req.data.ClientEmail).set({
                FirstName: req.data.FirstName,
                LastName: req.data.LastName
            })
        ]).then((resolve, reject) => {
            console.log("Resolve", resolve);
            console.log("Reject", reject);

            if (resolve[0] == 0) {
                req.error(409, "Record Not Found");
            }
        }).catch((err) => {
            console.log(err);
            req.error(err.code, err.message);
        });
        console.log("Before End", returnData);
        return returnData;
    });

    // ** DELETE **
    srv.on("DELETE", "Orders", async (req) => {        // DeleteOrder -> Orders
        let returnData = await cds.transaction(req).run(
            DELETE.from(Orders).where({
                ClientEmail: req.data.ClientEmail
            })
        ).then((resolve, reject) => {
            console.log("Resolve", resolve);
            console.log("Reject", reject);

            if (resolve !== 1) {
                req.error(409, "Record Not Found");
            }
        }).catch((err) => {
            console.log(err);
            req.error(err.code, err.message);
        });
        console.log("Before End", returnData);
        return await returnData;
    });

    // ** FUNCTION ** (no server side effect)
    srv.on("getClientTaxRate", async (req) => {
        // NO server side-effect
        const { clientEmail } = req.data;           // Se extrae el parámetro definido
        const db = srv.transaction(req);            // Recupera el obj p/trabajar con la DB

        const results = await db
            .read(Orders, ["Country_code"])         // Petición de lectura
            .where({ ClientEmail: clientEmail });

        console.log("Results[0]", results[0]);

        switch (results[0].Country_code) {
            case 'ES':
                return 21.5;
            case 'UK':
                return 24.6;
            default:
                break;
        }
    });

    // ** ACTION **
    srv.on("cancelOrder", async (req) => {
        const { clientEmail } = req.data;
        const db = srv.transaction(req);

        const resultsRead = await db
            .read(Orders, ["FirstName", "LastName", "Approved"])
            .where({ ClientEmail: clientEmail });

        let returnOrder = {
            status: "",
            message: ""
        };
        console.log("clientEmail", clientEmail);
        console.log("resultsRead", resultsRead);

        if (resultsRead[0].Approved == false) {
            const resultsUpdate = await db
                .update(Orders)
                .set({ Status: 'C' })
                .where({ ClientEmail: clientEmail });
                returnOrder.status = "Succeeded";
                returnOrder.message = `The Order placed by ${resultsRead[0].FirstName} ${resultsRead[0].LastName} was canceled`;
        } else {
            returnOrder.status = "Failed";
                returnOrder.message = `The Order placed by ${resultsRead[0].FirstName} ${resultsRead[0].LastName} was NOT canceled because was already approved`;
        }
        console.log("Action cancel order executed");
        return returnOrder;
    });
};