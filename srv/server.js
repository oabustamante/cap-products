// Se puede agrega funcionalidad adicional al proceso del arranque del servidor CAP Boostrap

const cds = require("@sap/cds");
const cors = require("cors");
const adapterProxy = require("@sap/cds-odata-v2-adapter-proxy");
const { executeHttpRequestWithOrigin } = require("@sap-cloud-sdk/http-client");

// Boostrap se ejecuta en el arranque del servidor
// Enhancement
cds.on("bootstrap", (app) => {
    app.use(adapterProxy());
    // Habilita las peticiones a servicios externos
    app.use(cors());
    // Params { req, res } - Si no se usa req, se manda "_"
    app.get("/alive", (_, res) => {
        res.status(200).send("Server is Alive");
    });
});

if (process.env.NODE_ENV !== 'production') {
    const swagger = require("cds-swagger-ui-express");
    cds.on("bootstrap", (app) => {
        app.use(swagger());
    });
    require("dotenv").config();
}
module.exports = cds.server;