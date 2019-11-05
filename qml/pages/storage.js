.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块
Qt.include("allposts.js");

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
                    tx.executeSql('CREATE TABLE IF NOT EXISTS kuaidi(id integer primary key AutoIncrement,postid TEXT,name TEXT,description TEXT,posttime TEXT);');

                });

}


var saveResult;
// 插入数据
function setKuaidi(postid, wuliutype,description) {
    var db = getDatabase();
    try{
        db.transaction(function(tx) {

            var rs = tx.executeSql('INSERT OR REPLACE INTO kuaidi(postid,name,description,posttime) VALUES (?,?,?,?);', [postid,wuliutype,description,getCurrentTime()]);
            if (rs.rowsAffected > 0) {
                saveResult = "OK";
            } else {
                saveResult = "Error";
            }
        });}
    catch(e){
        db.transaction(
                    function(tx) {
                        tx.executeSql('ALTER TABLE kuaidi ADD column posttime TEXT;');

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
        //console.log("ID::::::"+id);
        //console.log(rs.rowsAffected);
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



//根据id更新
function updateKuaidi(id,postid,description) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('update kuaidi set postid = ? ,description=? where id =?;',[postid,description,id]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

var listModel;
// 获取查询列表
function getKuaidi(all) {

    var sql='SELECT * FROM kuaidi order by id desc;';
    if(all === "three"){
        sql = 'SELECT * FROM kuaidi order by id desc limit 3;';
    }

    var db = getDatabase();
    listModel.clear()
    try{
        db.transaction(function(tx) {
            var rs = tx.executeSql(sql);
            if (rs.rows.length > 0) {
                for(var i = 0; i < rs.rows.length; i++){
                    listModel.append({
                                         "id":rs.rows.item(i).id,
                                         "postid":rs.rows.item(i).postid,
                                         "name": rs.rows.item(i).name,
                                         "description":rs.rows.item(i).description,
                                         "posttime":rs.rows.item(i).posttime

                                     })
                }
            }
        })}
    catch(e){
        console.log("error...", e)
    }
}

var description;
// 获取单条查询记录
function getKuaidiInfo(id) {
    progress.visible=true;
    var db = getDatabase();
    var name="";
    var postid="";
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


