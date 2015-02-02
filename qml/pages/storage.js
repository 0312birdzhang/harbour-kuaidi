.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块
//storage.js
// 首先创建一个helper方法连接数据库
function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("mykuaidi", "1.0", "postinfo", 10000);

}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS kuaidi(id integer primary key AutoIncrement,postid TEXT,name TEXT);');

                });
}

// 插入数据
function setKuaidi(postid, wuliutype) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO kuaidi(postid,name) VALUES (?,?);', [postid,wuliutype]);
        //console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

// 清除数据
function clearKuaidi(id) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from kuaidi where id =?;',[id]);
        console.log("ID::::::"+id);
         console.log(rs.rowsAffected);
        if (rs.rowsAffected > 0) {

            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

//根据name删除
function clearByname(name) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from  kuaidi where name =?;',[name]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}
// 获取查询列表
function getKuaidi() {
    var db = getDatabase();
    var res="";
    listModel.clear()
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM kuaidi;');
        if (rs.rows.length > 0) {
            for(var i = 0; i < rs.rows.length; i++){
                listModel.append({
                                     "id":rs.rows.item(i).id,
                                     "postid":rs.rows.item(i).postid,
                                     "name":dictnames(rs.rows.item(i).name)
                                 }
                                 )
            }
        } else {
            header.title="无结果";
        }
    });
}

// 获取单条查询记录
function getKuaidiInfo(id) {
    progress.visible=true;
    var db = getDatabase();
    var name="";
    var postid="";
    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM kuaidi where id =?;',[id]);
        if (rs.rows.length > 0) {
            postid = rs.rows.item(0).postid;
            name = rs.rows.item(0).name;
            load(name,postid);

        } else {
            res = "查询出错了，(⊙o⊙)…";

        }
    });
}

// 判断是否已经存在
function isExist(postid) {
    var db = getDatabase();
    var res="true";
    db.transaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM kuaidi where postid =?",[postid]);
        if (rs.rowsAffected > 0) {
                res = "true";
        } else {
            res = "false";
        }

    });


    return res;
}





//不能导入，只能重新复制一遍了,囧
function load(type,postid) {

    listdetailModel.clear();
    console.log("type:"+type+",postid:"+postid);
    var xhr = new XMLHttpRequest();
    var url="http://www.kuaidi100.com/query?type="+type+"&postid="+postid
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                //var jsonObject = xhr.responseText;
                 loaded(jsonObject);

            }
        }
    }
    xhr.send();
}



function loaded(jsonObject)
{
    var alltext = "";
    if(jsonObject.status != "200" ){
        listdetailModel.append({
                                   "res":"错误代码："+jsonObject.status+"<br>"+jsonObject.message
                               });
        alltext = "错误代码："+jsonObject.status+"<br>"+jsonObject.message;
    }
    else{
        for ( var process in jsonObject.data   )
        {
            //最近物流黄色标注
            if( process == 0 ){
                    listdetailModel.append({
                                         "sort":process,
                                         "time" : "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>",
                                         "context" : "<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"


                                     });
                    alltext += "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>"+"<br>"+"<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"+"<br>"
                }else{
                    listdetailModel.append({
                                 "sort":process,
                                 "time" : jsonObject.data[process].time,
                                 "context" : jsonObject.data[process].context


                             });
                    alltext += jsonObject.data[process].time+"<br>"+jsonObject.data[process].context+"<br>"
                }
        }
//        listdetailModel.append({
//                                   "res":alltext
//                               });

    }
    progress.visible = false;
    return alltext;
}

//快递字典
function dictnames(name){

    var postnames={
         "shentong":"申通",
         "ems":"EMS",
        "shunfeng":"顺丰" ,
         "yuantong":"圆通",
        "zhongtong":"中通" ,
         "yunda":"韵达",
        "tiantian" :"天天",
         "huitongkuaidi":"汇通",
        "quanfengkuaidi" :"全峰",
         "debangwuliu":"德邦",
        "zhaijisong:":"宅急送"
    }
    try{
        return postnames[name];
    }
    catch(e){
        return "error"
    }

}
