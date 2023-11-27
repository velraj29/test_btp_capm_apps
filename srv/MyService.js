module.exports = (cds) => {
    cds.on('hello', (req) => {
        return "welcome" + req.data.name + "welcome to CAP";
    });

    const { ReadEmployeeSrv } = cds.entities;
    cds.on('READ', ReadEmployeeSrv, () => {
        let aData = [];
        aData.push({
            "ID": "02BD2137-0890-1EEA-A6C2-BB55C19787FB",
            "nameFirst": "Sachin",
            "nameLast": "Tendulkar",
        })
        aData.push({
            "ID": "02BD2137-0890-1EEA-A6C2-BB55C19787FB",
            "nameFirst": "Virat",
            "nameLast": "Kohli",
        })
        return aData;
    });
}