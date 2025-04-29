using {sapbackend as external} from './external/sapbackend.csn';

@graphql
define service SAPBackendExit {
    @cds.persistence: {
        table,
        skip: false
    }
    @cds.autoexpose
    // entity Incidents as
    //      select from external.IncidentsSet;

    // Para el ejercicio de la personalización del query
    entity Incidents as projection on external.IncidentsSet;

// select from external.IncidentsSet {
//     IncidenceId,
//     EmployeeId,
//     '' as Newproperty
// };
}

@protocol: 'rest'
service RestService {
    entity Incidents as projection on SAPBackendExit.Incidents
}