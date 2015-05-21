Qt.include("allposts.js");
var themeColor;

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






