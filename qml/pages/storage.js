.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块

var themeColor;

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
                    tx.executeSql('CREATE TABLE IF NOT EXISTS kuaidi(id integer primary key AutoIncrement,postid TEXT,name TEXT,description TEXT);');

                });
}


var saveResult;
// 插入数据
function setKuaidi(postid, wuliutype,description) {
    var db = getDatabase();
    try{
    db.transaction(function(tx) {

        var rs = tx.executeSql('INSERT OR REPLACE INTO kuaidi(postid,name,description) VALUES (?,?,?);', [postid,wuliutype,description]);
            if (rs.rowsAffected > 0) {
                saveResult = "OK";
            } else {
                saveResult = "Error";
            }
        });}
    catch(e){
        db.transaction(
                    function(tx) {
                        tx.executeSql('ALTER TABLE kuaidi ADD description TEXT;');

                    });
         saveResult = "Error";
    }
    return saveResult;

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
function getKuaidi(all) {

    var sql='SELECT * FROM kuaidi order by id desc;';
    if(all === "three"){
        sql = 'SELECT * FROM kuaidi order by id desc limit 3;';

    }

    var db = getDatabase();
    var res="";
    listModel.clear()
    db.transaction(function(tx) {
        var rs = tx.executeSql(sql);
        if (rs.rows.length > 0) {
            for(var i = 0; i < rs.rows.length; i++){
                listModel.append({
                                     "id":rs.rows.item(i).id,
                                     "postid":rs.rows.item(i).postid,
                                     "name":dictnames(rs.rows.item(i).name),
                                     "description":rs.rows.item(i).description

                                 }
                                 )
            }
        }
    });
}

// 获取单条查询记录
function getKuaidiInfo(id) {
    progress.visible=true;
    var db = getDatabase();
    var name="";
    var postid="";
    var description;

    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM kuaidi where id =?;',[id]);
        if (rs.rows.length > 0) {
            postid = rs.rows.item(0).postid;
            name = rs.rows.item(0).name;

            description = rs.rows.item(0).description;
            load(name,postid);

        } else {
            description =  "无";
            res = "查询出错了，(⊙o⊙)…";

        }
    });

    return description;
}


// 判断是否已经存在
function isExist(postid) {
    var exist;
    //console.log("POSTID:"+postid);
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql("SELECT count(1) as count FROM kuaidi where postid = ?",[postid.toString()]);
        //console.log("COUNT:"+rs.rows.item(0).count);
        if (rs.rows.item(0).count > 0) {
              exist = "true";
        } else {
            exist = "false";
        }

    });



    return exist;

}







function load(type,postid) {

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

                loaded(jsonObject);


            }
        }
    }
    xhr.send();
}



function loaded(jsonObject){
    var alltext="<br>";
    if(jsonObject.status != "200" ){
        alltext = "错误代码："+jsonObject.status+"<br >"+jsonObject.message;

    }
    else{
        for ( var process in jsonObject.data   ){
            //最近物流根据主题高亮
            if( process == 0 ){

                    alltext += "<font color='"+themeColor+"'>"+jsonObject.data[process].time+"</font><br><font color='"+themeColor+"'>"+jsonObject.data[process].context+"</font>"+"<br>"
                }else{

                    alltext += jsonObject.data[process].time+"<br>"+jsonObject.data[process].context+"<br>";
                }
        }

    }
    progress.visible = false;
    postinfo = alltext;
    //return alltext;
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
