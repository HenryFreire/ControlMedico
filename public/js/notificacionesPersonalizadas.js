function success( icon, msg ){
    notif({
        type: "success",
        msg: `<p align='left'><i class="${icon}"></i> ${msg} </p>`,
        width: 240,
        multiline: true,
        bgcolor:"#45cc47",
        color:"#ffffff",
        clickable: true,
        position: "right",
    });
}

function info( icon, msg ){
    notif({
        type: "info",
        msg: `<p align='left'><i class="${icon}"></i> ${msg} </p>`,
        width: 240,
        multiline: true,
        bgcolor:"#59b7c1",
        color:"#ffffff",
        clickable: true,
        position: "right",
    });
}

function error( icon, msg ){
    notif({
        type: "error",
        msg: `<p align='left'><i class="${icon}"></i> ${msg} </p>`,
        width: 240,
        multiline: true,
        bgcolor:"#f25135",
        color:"#ffffff",
        clickable: true,
        position: "right",
    });
}