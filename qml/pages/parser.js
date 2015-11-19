Qt.include("allposts.js");
var themeColor;

function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:break;
                case xmlhttp.HEADERS_RECEIVED:
                  if (xmlhttp.status != 200){
                    }
                  break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            //console.log("Server Msg:"+xmlhttp.responseXML);
                            callback(xmlhttp.responseText);
                            //signalcenter.loadFinished();
                        } catch(e) {
                            //signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        //signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

var autopostModel;
function getPostname(postnum){
    var url="http://m.kuaidi100.com/autonumber/auto?num="+postnum;
    sendWebRequest(url,loadPostname,"GET","");
}

function loadPostname(oritxt){
    var obj=JSON.parse(oritxt);
    autopostModel.clear();
    for(var i in obj){
        autopostModel.append({
                              "value":obj[i].comCode,
                              "label":getLabel(obj[i].comCode)
                            });
    }

}


//查询快递
function load(type,postid) {
    progress.visible = true;
    listModel.clear();
    var xhr = new XMLHttpRequest();

    var url="http://m.kuaidi100.com/query?type="+type+"&postid="+postid+"&id=1&valicode=&temp="+getRandom();
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                //var jsonObject = xhr.responseText;
                loaded(jsonObject)
            }
        }
    }

    xhr.send();
}



function loaded(jsonObject)
{
    if(jsonObject.status != "200" ){
        savebutton.enabled = true;
        listModel.append({
                             "sort":"",
                             "time":"",
                             "context":jsonObject.message+"<br/><br/>"+"<font color='" + Theme.highlightColor + "'>可能存在"+
                              "快递延误,请保存订单稍后再试^_^</font>"
                         });
    }
    else{
        savebutton.enabled = true;
        for ( var process in jsonObject.data   )
        {
            //最近物流黄色标注
            if( process == 0 ){
					listModel.append({
										 "sort":process,
                                         "time" : "<font color='" + Theme.highlightColor + "'>"+jsonObject.data[process].time+"</font>",
                                         "context" : "<font color='" + Theme.highlightColor + "'>"+jsonObject.data[process].context+"</font>"

									 });

				}else{
					listModel.append({
                                 "sort":process,
                                 "time" : jsonObject.data[process].time,
                                 "context" : jsonObject.data[process].context


                             });
				}

        }
    }
        progress.visible = false;
}
