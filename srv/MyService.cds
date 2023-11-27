using { mypoapp.db.master } from '../db/dataModel';

service MyService {
    function hello(name: String(10)) returns String;

    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
}