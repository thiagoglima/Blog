function ValidaVariavel(sender) {
    try
    {
        if (sender == null || sender == undefined || sender == '')
        { return false; }
        else
        { return true; }
    }
    catch (e)
    {
        console.log(e.message);
        return false;
    }
}

var xmlHttp = new Array();
var DataXmlHttp = new Array();

function SubmitHttp(url, method) {
    var methodname = method.toString().match(/^function ([^(]+)/)[1];
    if (window.ActiveXObject) {
        xmlHttp[methodname] = new ActiveXObject('Microsoft.XMLHTTP');
    } else if (window.XMLHttpRequest) {
        xmlHttp[methodname] = new XMLHttpRequest();
    }
    else {
        return;
    }

    xmlHttp[methodname].open('GET', url, true);
    xmlHttp[methodname].onreadystatechange = method;
    xmlHttp[methodname].send(null);
    DataXmlHttp[methodname] = new Date();
}
