const cds = require("@sap/cds");

// module.exports = cds.service.impl(async function(srv) {
//     const { Incidents } = srv.entities;
//     // El nombre cds.connect.to("sapbackend") debe coincidir con lo que se tiene en el package.json
//     const sapbackend = await cds.connect.to('sapbackend');  // A PARTIR DE AQUI MARCA EL ERROR
//     srv.on("READ", Incidents, async (req) => {
//         return await sapbackend.tx(req).send({
//             query: req.query,     // La misma que se ejecuta en la petición; por lo que la ponemos tal cual
//             headers: {
//                 Authorization: "Basic c2FwdWk1OnNhcHVpNQ=="
//             }
//         });
//     });
// });

// // "srv" puede sustituirse por "this"
// module.exports = cds.service.impl(async function () {
//     const { Incidents } = this.entities;
//     // El nombre cds.connect.to("sapbackend") debe coincidir con lo que se tiene en el package.json
//     const sapbackend = await cds.connect.to('sapbackend');  // A PARTIR DE AQUI MARCA EL ERROR
//     this.on("READ", Incidents, async (req) => {
//         return await sapbackend.tx(req).send({
//             query: req.query,     // La misma que se ejecuta en la petición; por lo que la ponemos tal cual
//             headers: {
//                 Authorization: "Basic c2FwdWk1OnNhcHVpNQ=="
//             }
//         });
//     });
// });

// module.exports = cds.service.impl(async function() {
//     const { Incidents } = this.entities;
//     const sapbackend = await cds.connect.to('sapbackend');  
//     this.on("READ", Incidents, async (req) => {
//         return await sapbackend.tx(req).send({
//             query: req.query,     // La misma que se ejecuta en la petición; por lo que la ponemos tal cual
//             headers: {
//                 Authorization: "Basic c2FwdWk1OnNhcHVpNQ=="
//             }
//         });
//     });
// });


module.exports = async (srv) => {
    const sapbackend = await cds.connect.to('sapbackend');
    const { Incidents } = srv.entities;

    srv.on(["READ"], Incidents, async (req) => {
        // Query en base a la petición
        let IncidentsQuery = SELECT.from(req.query.SELECT.from).limit(req.query.SELECT.limit);

        if (req.query.SELECT.where) {
            IncidentsQuery.where(req.query.SELECT.where);
        }
        if (req.query.SELECT.orderBy) {
            IncidentsQuery.orderBy(req.query.SELECT.orderBy);
        }

        let incident = await sapbackend.tx(req).send({
            query: IncidentsQuery,
            headers: {
                //Authorization: "Basic c2FwdWk1OnNhcHVpNQ=="
                Authorization: `${process.env.SAP_GATEWAY_AUTH}`
            }
        });

        let incidents = [];
        if (Array.isArray(incident)) {
            incidents = incident;
        } else {
            incidents[0] = incident;
        }
        return incidents;
    });
};
