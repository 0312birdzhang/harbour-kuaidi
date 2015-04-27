
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
                             "time":"错误代码："+jsonObject.status,
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


function getRandom(){
    var Num="";
    for(var i=0;i<16;i++){
    Num+=Math.floor(Math.random()*10);
    }
    Num = "0."+Num;
    console.log("random num:"+Num);
    return Num;
}

//支持的所有快递商
var allpost = ([
            {"value":'ems',"label":"EMS"},
            {"value":'shentong',"label":"申通快递"},
            {"value":'shunfeng',"label":"顺丰速运"},
            {"value":'yuantong',"label":"圆通速递"},
            {"value":'yunda',"label":"韵达快运"},
            {"value":'zhongtong',"label":"中通快递"},
            {"value":'huitongkuaidi',"label":"汇通快运"},
            {"value":'tiantian',"label":"天天快递"},
            {"value":'zhaijisong',"label":"宅急送"},
            {"value":'debangwuliu',"label":"德邦物流"},
            {"value":'zhongtiewuliu',"label":"中铁快运"},
            {"value":'lianbangkuaidi',"label":"联邦快递"},
            {"value":'youzhengguonei',"label":"邮政国内包裹"},
            {"value":'youzhengguoji',"label":"邮政国际包裹"},
            {"value":'emsguoji',"label":"EMS国际快递"},
            {"value":'aae',"label":"AAE-中国"},
            {"value":'anjiekuaidi',"label":"安捷快递"},
            {"value":'anxindakuaixi',"label":"安信达"},
            {"value":'youzhengguonei',"label":"包裹/平邮/挂号信"},
            {"value":'bht',"label":"BHT国际快递"},
            {"value":'baifudongfang',"label":"百福东方"},
            {"value":'cces',"label":"CCES（希伊艾斯）"},
            {"value":'lijisong',"label":"成都立即送"},
            {"value":'dhl',"label":"DHL"},
            {"value":'dhlde',"label":"DHL德国"},
            {"value":'dsukuaidi',"label":"D速物流"},
            {"value":'debangwuliu',"label":"德邦物流"},
            {"value":'datianwuliu',"label":"大田物流"},
            {"value":'dpex',"label":"DPEX"},
            {"value":'disifang',"label":"递四方"},
            {"value":'ems',"label":"EMS - 国内"},
            {"value":'emsguoji',"label":"EMS - 国际"},
            {"value":'ems',"label":"E邮宝"},
            {"value":'rufengda',"label":"凡客"},
            {"value":'fedexus',"label":"FedEx - 美国"},
            {"value":'fedex',"label":"FedEx - 国际"},
            {"value":'lianbangkuaidi',"label":"FedEx - 国内"},
            {"value":'feikangda',"label":"飞康达"},
            {"value":'youzhengguonei',"label":"挂号信"},
            {"value":'ganzhongnengda',"label":"能达速递"},
            {"value":'gongsuda',"label":"共速达"},
            {"value":'gls',"label":"GLS"},
            {"value":'tiantian',"label":"海航天天"},
            {"value":'huitongkuaidi',"label":"汇通快运"},
            {"value":'tiandihuayu',"label":"华宇物流"},
            {"value":'hengluwuliu',"label":"恒路物流"},
            {"value":'haiwaihuanqiu',"label":"海外环球"},
            {"value":'huaxialongwuliu',"label":"华夏龙"},
            {"value":'jiajiwuliu',"label":"佳吉快运"},
            {"value":'jialidatong',"label":"嘉里大通"},
            {"value":'jiayiwuliu',"label":"佳怡物流"},
            {"value":'jinguangsudikuaijian',"label":"京广速递"},
            {"value":'jindawuliu',"label":"金大物流"},
            {"value":'jinyuekuaidi',"label":"晋越快递"},
            {"value":'jixianda',"label":"急先达"},
            {"value":'jiayunmeiwuliu',"label":"加运美"},
            {"value":'kuaijiesudi',"label":"快捷速递"},
            {"value":'lianbangkuaidi',"label":"联邦快递"},
            {"value":'longbanwuliu',"label":"龙邦速递"},
            {"value":'lanbiaokuaidi',"label":"蓝镖快递"},
            {"value":'lijisong',"label":"立即送"},
            {"value":'lejiedi',"label":"乐捷递"},
            {"value":'lianhaowuliu',"label":"联昊通"},
            {"value":'minghangkuaidi',"label":"民航快递"},
            {"value":'meiguokuaidi',"label":"美国快递"},
            {"value":'menduimen',"label":"门对门"},
            {"value":'ocs',"label":"OCS"},
            {"value":'quanfengkuaidi',"label":"全峰快递"},
            {"value":'quanyikuaidi',"label":"全一快递"},
            {"value":'quanchenkuaidi',"label":"全晨快递"},
            {"value":'quanjitong',"label":"全际通"},
            {"value":'quanritongkuaidi',"label":"全日通"},
            {"value":'rufengda',"label":"如风达"},
            {"value":'shentong',"label":"申通E物流"},
            {"value":'shentong',"label":"申通快递"},
            {"value":'shunfeng',"label":"顺丰速运"},
            {"value":'suer',"label":"速尔快递"},
            {"value":'shenghuiwuliu',"label":"盛辉物流"},
            {"value":'shengfengwuliu',"label":"盛丰物流"},
            {"value":'shangda',"label":"上大国际"},
            {"value":'santaisudi',"label":"三态速递"},
            {"value":'haihongwangsong',"label":"山东海红"},
            {"value":'saiaodi',"label":"赛澳递"},
            {"value":'tnt',"label":"TNT"},
            {"value":'tiantian',"label":"天天快递"},
            {"value":'tiandihuayu',"label":"天地华宇"},
            {"value":'tonghetianxia',"label":"通和天下"},
            {"value":'ups',"label":"UPS"},
            {"value":'usps',"label":"USPS（美国邮政）"},
            {"value":'wanjiawuliu',"label":"万家物流"},
            {"value":'wanxiangwuliu',"label":"万象物流"},
            {"value":'weitepai',"label":"微特派"},
            {"value":'xinbangwuliu',"label":"新邦物流"},
            {"value":'xinfengwuliu',"label":"信丰物流"},
            {"value":'cces',"label":"希伊艾斯（CCES）"},
            {"value":'yuantong',"label":"圆通速递"},
            {"value":'yunda',"label":"韵达快运"},
            {"value":'youzhengguonei',"label":"邮政国内包裹"},
            {"value":'youzhengguoji',"label":"邮政国际包裹"},
            {"value":'ems',"label":"邮政特快专递"},
            {"value":'yuanchengwuliu',"label":"远成物流"},
            {"value":'yafengsudi',"label":"亚风速递"},
            {"value":'yuanweifeng',"label":"源伟丰"},
            {"value":'youshuwuliu',"label":"优速快递"},
            {"value":'yuanzhijiecheng',"label":"元智捷诚"},
            {"value":'yuefengwuliu',"label":"越丰物流"},
            {"value":'yuananda',"label":"源安达"},
            {"value":'yuanfeihangwuliu',"label":"原飞航"},
            {"value":'yinjiesudi',"label":"银捷速递"},
            {"value":'yuntongkuaidi',"label":"运通中港"},
            {"value":'zhaijisong',"label":"宅急送"},
            {"value":'zhongtong',"label":"中通快递"},
            {"value":'zhongtiewuliu',"label":"中铁快运"},
            {"value":'ztky',"label":"中铁物流"},
            {"value":'zhongyouwuliu',"label":"中邮物流"},
            {"value":'zhimakaimen',"label":"芝麻开门"},
            {"value":'zhongxinda',"label":"忠信达"},
            {"value":'zhengzhoujianhua',"label":"郑州建华"}
            ]);


