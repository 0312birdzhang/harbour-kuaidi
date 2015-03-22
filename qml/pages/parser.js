
//查询快递
function load(type,postid) {
    progress.visible = true;
    listModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://www.kuaidi100.com/query?type="+type+"&postid="+postid
    //var url = "http://www.kuaidi100.com/query?type=shentong&postid=868509042695"
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
                             "time":"错误代码："+jsonObject.status,
                             "context":jsonObject.message+"<br/>请保存订单稍后再试"
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
										 "time" : "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>",
										 "context" : "<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"
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


