//支持的所有快递商
var allpost = ([
    {
        "value": "yuantong",
        "label": "圆通快递"
    },
    {
        "value": "shentong",
        "label": "申通快递"
    },
    {
        "value": "shunfeng",
        "label": "顺丰快递"
    },
    {
        "value": "yunda",
        "label": "韵达快递"
    },
    {
        "value": "debangwuliu",
        "label": "德邦物流"
    },
    {
        "value": "zhongtong",
        "label": "中通快递"
    },
    {
        "value": "huitongkuaidi",
        "label": "百世汇通"
    },
    {
        "value": "youzhengguonei",
        "label": "邮政包裹"
    },
    {
        "value": "ems",
        "label": "EMS"
    },
    {
        "value": "annengwuliu",
        "label": "安能物流"
    },
    {
        "value": "anxl",
        "label": "安迅物流"
    },
    {
        "value": "youzhengguonei",
        "label": "包裹/平邮/挂号信"
    },
    {
        "value": "balunzhi",
        "label": "巴伦支快递"
    },
    {
        "value": "xiaohongmao",
        "label": "北青小红帽"
    },
    {
        "value": "huitongkuaidi",
        "label": "百世汇通"
    },
    {
        "value": "baifudongfang",
        "label": "百福东方物流"
    },
    {
        "value": "bangsongwuliu",
        "label": "邦送物流"
    },
    {
        "value": "lbbk",
        "label": "宝凯物流"
    },
    {
        "value": "bqcwl",
        "label": "百千诚物流"
    },
    {
        "value": "byht",
        "label": "博源恒通"
    },
    {
        "value": "coe",
        "label": "COE（东方快递）"
    },
    {
        "value": "city100",
        "label": "城市100"
    },
    {
        "value": "chuanxiwuliu",
        "label": "传喜物流"
    },
    {
        "value": "chengjisudi",
        "label": "城际速递"
    },
    {
        "value": "lijisong",
        "label": "成都立即送"
    },
    {
        "value": "chukou1",
        "label": "出口易"
    },
    {
        "value": "dhl",
        "label": "DHL快递（中国件）"
    },
    {
        "value": "dhlen",
        "label": "DHL（国际件）"
    },
    {
        "value": "dhlde",
        "label": "DHL（德国件）"
    },
    {
        "value": "debangwuliu",
        "label": "德邦"
    },
    {
        "value": "datianwuliu",
        "label": "大田物流"
    },
    {
        "value": "coe",
        "label": "东方快递"
    },
    {
        "value": "disifang",
        "label": "递四方"
    },
    {
        "value": "dayangwuliu",
        "label": "大洋物流"
    },
    {
        "value": "diantongkuaidi",
        "label": "店通快递"
    },
    {
        "value": "dechuangwuliu",
        "label": "德创物流"
    },
    {
        "value": "donghong",
        "label": "东红物流"
    },
    {
        "value": "dsukuaidi",
        "label": "D速物流"
    },
    {
        "value": "donghanwl",
        "label": "东瀚物流"
    },
    {
        "value": "dfpost",
        "label": "达方物流"
    },
    {
        "value": "ems",
        "label": "EMS快递查询"
    },
    {
        "value": "emsguoji",
        "label": "EMS国际快递查询"
    },
    {
        "value": "fedex",
        "label": "FedEx快递查询"
    },
    {
        "value": "fedex",
        "label": "FedEx国际件"
    },
    {
        "value": "fedexus",
        "label": "FedEx（美国）"
    },
    {
        "value": "rufengda",
        "label": "凡客如风达"
    },
    {
        "value": "feikangda",
        "label": "飞康达物流"
    },
    {
        "value": "feibaokuaidi",
        "label": "飞豹快递"
    },
    {
        "value": "feihukuaidi",
        "label": "飞狐快递"
    },
    {
        "value": "fanyukuaidi",
        "label": "凡宇速递"
    },
    {
        "value": "fandaguoji",
        "label": "颿达国际"
    },
    {
        "value": "feiyuanvipshop",
        "label": "飞远配送"
    },
    {
        "value": "guotongkuaidi",
        "label": "国通快递"
    },
    {
        "value": "youzhengguoji",
        "label": "国际邮件查询"
    },
    {
        "value": "ganzhongnengda",
        "label": "港中能达物流"
    },
    {
        "value": "youzhengguonei",
        "label": "挂号信/国内邮件"
    },
    {
        "value": "gongsuda",
        "label": "共速达"
    },
    {
        "value": "gtongsudi",
        "label": "广通速递"
    },
    {
        "value": "gdkd",
        "label": "港快速递"
    },
    {
        "value": "gaticn",
        "label": "GATI快递"
    },
    {
        "value": "hre",
        "label": "高铁速递"
    },
    {
        "value": "gda",
        "label": "冠达快递"
    },
    {
        "value": "tiandihuayu",
        "label": "华宇物流"
    },
    {
        "value": "hengluwuliu",
        "label": "恒路物流"
    },
    {
        "value": "hlyex",
        "label": "好来运快递"
    },
    {
        "value": "huaxialongwuliu",
        "label": "华夏龙物流"
    },
    {
        "value": "tiantian",
        "label": "海航天天"
    },
    {
        "value": "hebeijianhua",
        "label": "河北建华"
    },
    {
        "value": "haimengsudi",
        "label": "海盟速递"
    },
    {
        "value": "huaqikuaiyun",
        "label": "华企快运"
    },
    {
        "value": "haoshengwuliu",
        "label": "昊盛物流"
    },
    {
        "value": "hutongwuliu",
        "label": "户通物流"
    },
    {
        "value": "hzpl",
        "label": "华航快递"
    },
    {
        "value": "huangmajia",
        "label": "黄马甲快递"
    },
    {
        "value": "ucs",
        "label": "合众速递（UCS）"
    },
    {
        "value": "pfcexpress",
        "label": "皇家物流"
    },
    {
        "value": "huoban",
        "label": "伙伴物流"
    },
    {
        "value": "jiajiwuliu",
        "label": "佳吉物流"
    },
    {
        "value": "jiayiwuliu",
        "label": "佳怡物流"
    },
    {
        "value": "jiayunmeiwuliu",
        "label": "加运美快递"
    },
    {
        "value": "jixianda",
        "label": "急先达物流"
    },
    {
        "value": "jinguangsudikuaijian",
        "label": "京广速递快件"
    },
    {
        "value": "jinyuekuaidi",
        "label": "晋越快递"
    },
    {
        "value": "jd",
        "label": "京东快递"
    },
    {
        "value": "jietekuaidi",
        "label": "捷特快递"
    },
    {
        "value": "jiuyicn",
        "label": "久易快递"
    },
    {
        "value": "kuaijiesudi",
        "label": "快捷快递"
    },
    {
        "value": "kangliwuliu",
        "label": "康力物流"
    },
    {
        "value": "kuayue",
        "label": "跨越物流"
    },
    {
        "value": "kuaiyouda",
        "label": "快优达速递"
    },
    {
        "value": "kuaitao",
        "label": "快淘快递"
    },
    {
        "value": "lianbangkuaidi",
        "label": "联邦快递（国内）"
    },
    {
        "value": "lianhaowuliu",
        "label": "联昊通物流"
    },
    {
        "value": "longbanwuliu",
        "label": "龙邦速递"
    },
    {
        "value": "lejiedi",
        "label": "乐捷递"
    },
    {
        "value": "lijisong",
        "label": "立即送"
    },
    {
        "value": "lanhukuaidi",
        "label": "蓝弧快递"
    },
    {
        "value": "minghangkuaidi",
        "label": "民航快递"
    },
    {
        "value": "meiguokuaidi",
        "label": "美国快递"
    },
    {
        "value": "menduimen",
        "label": "门对门"
    },
    {
        "value": "mingliangwuliu",
        "label": "明亮物流"
    },
    {
        "value": "minbangsudi",
        "label": "民邦速递"
    },
    {
        "value": "minshengkuaidi",
        "label": "闽盛快递"
    },
    {
        "value": "ganzhongnengda",
        "label": "能达速递"
    },
    {
        "value": "nuoyaao",
        "label": "偌亚奥国际"
    },
    {
        "value": "nanjingshengbang",
        "label": "南京晟邦物流"
    },
    {
        "value": "pingandatengfei",
        "label": "平安达腾飞"
    },
    {
        "value": "peixingwuliu",
        "label": "陪行物流"
    },
    {
        "value": "quanfengkuaidi",
        "label": "全峰快递"
    },
    {
        "value": "quanyikuaidi",
        "label": "全一快递"
    },
    {
        "value": "quanritongkuaidi",
        "label": "全日通快递"
    },
    {
        "value": "quanchenkuaidi",
        "label": "全晨快递"
    },
    {
        "value": "sevendays",
        "label": "7天连锁物流"
    },
    {
        "value": "rufengda",
        "label": "如风达快递"
    },
    {
        "value": "riyuwuliu",
        "label": "日昱物流"
    },
    {
        "value": "shentong",
        "label": "申通快递"
    },
    {
        "value": "shunfeng",
        "label": "顺丰速运"
    },
    {
        "value": "suer",
        "label": "速尔快递"
    },
    {
        "value": "haihongwangsong",
        "label": "山东海红"
    },
    {
        "value": "shenghuiwuliu",
        "label": "盛辉物流"
    },
    {
        "value": "shiyunkuaidi",
        "label": "世运快递"
    },
    {
        "value": "shengfengwuliu",
        "label": "盛丰物流"
    },
    {
        "value": "shangda",
        "label": "上大物流"
    },
    {
        "value": "santaisudi",
        "label": "三态速递"
    },
    {
        "value": "saiaodi",
        "label": "赛澳递"
    },
    {
        "value": "shentong",
        "label": "申通E物流"
    },
    {
        "value": "shenganwuliu",
        "label": "圣安物流"
    },
    {
        "value": "sxhongmajia",
        "label": "山西红马甲"
    },
    {
        "value": "suijiawuliu",
        "label": "穗佳物流"
    },
    {
        "value": "syjiahuier",
        "label": "沈阳佳惠尔"
    },
    {
        "value": "shlindao",
        "label": "上海林道货运"
    },
    {
        "value": "tnt",
        "label": "TNT快递"
    },
    {
        "value": "tiantian",
        "label": "天天快递"
    },
    {
        "value": "tiandihuayu",
        "label": "天地华宇"
    },
    {
        "value": "tonghetianxia",
        "label": "通和天下"
    },
    {
        "value": "tianzong",
        "label": "天纵物流"
    },
    {
        "value": "ups",
        "label": "UPS快递查询"
    },
    {
        "value": "ups",
        "label": "UPS国际快递"
    },
    {
        "value": "youshuwuliu",
        "label": "UC优速快递"
    },
    {
        "value": "usps",
        "label": "USPS美国邮政"
    },
    {
        "value": "wanxiangwuliu",
        "label": "万象物流"
    },
    {
        "value": "weitepai",
        "label": "微特派"
    },
    {
        "value": "wanjiawuliu",
        "label": "万家物流"
    },
    {
        "value": "xiyoutekuaidi",
        "label": "希优特快递"
    },
    {
        "value": "xinbangwuliu",
        "label": "新邦物流"
    },
    {
        "value": "xinfengwuliu",
        "label": "信丰物流"
    },
    {
        "value": "neweggozzo",
        "label": "新蛋物流"
    },
    {
        "value": "xianglongyuntong",
        "label": "祥龙运通物流"
    },
    {
        "value": "xianchengliansudi",
        "label": "西安城联速递"
    },
    {
        "value": "xilaikd",
        "label": "西安喜来快递"
    },
    {
        "value": "yuantong",
        "label": "圆通速递"
    },
    {
        "value": "yunda",
        "label": "韵达快运"
    },
    {
        "value": "yuntongkuaidi",
        "label": "运通快递"
    },
    {
        "value": "youzhengguonei",
        "label": "邮政国内"
    },
    {
        "value": "youzhengguoji",
        "label": "邮政国际"
    },
    {
        "value": "yuanchengwuliu",
        "label": "远成物流"
    },
    {
        "value": "yafengsudi",
        "label": "亚风速递"
    },
    {
        "value": "youshuwuliu",
        "label": "优速快递"
    },
    {
        "value": "yishunhang",
        "label": "亿顺航"
    },
    {
        "value": "yuefengwuliu",
        "label": "越丰物流"
    },
    {
        "value": "yuananda",
        "label": "源安达快递"
    },
    {
        "value": "yuanfeihangwuliu",
        "label": "原飞航物流"
    },
    {
        "value": "ems",
        "label": "邮政EMS速递"
    },
    {
        "value": "yinjiesudi",
        "label": "银捷速递"
    },
    {
        "value": "yitongfeihong",
        "label": "一统飞鸿"
    },
    {
        "value": "yuxinwuliu",
        "label": "宇鑫物流"
    },
    {
        "value": "yitongda",
        "label": "易通达"
    },
    {
        "value": "youbijia",
        "label": "邮必佳"
    },
    {
        "value": "yiqiguojiwuliu",
        "label": "一柒物流"
    },
    {
        "value": "yinsu",
        "label": "音素快运"
    },
    {
        "value": "yilingsuyun",
        "label": "亿领速运"
    },
    {
        "value": "yujiawuliu",
        "label": "煜嘉物流"
    },
    {
        "value": "gml",
        "label": "英脉物流"
    },
    {
        "value": "leopard",
        "label": "云豹国际货运"
    },
    {
        "value": "zhongtong",
        "label": "中通快递"
    },
    {
        "value": "zhaijisong",
        "label": "宅急送"
    },
    {
        "value": "zhongtiewuliu",
        "label": "中铁快运"
    },
    {
        "value": "ztky",
        "label": "中铁物流"
    },
    {
        "value": "zhongyouwuliu",
        "label": "中邮物流"
    },
    {
        "value": "coe",
        "label": "中国东方(COE)"
    },
    {
        "value": "zhimakaimen",
        "label": "芝麻开门"
    },
    {
        "value": "youzhengguonei",
        "label": "中国邮政快递"
    },
    {
        "value": "zhengzhoujianhua",
        "label": "郑州建华"
    },
    {
        "value": "zhongsukuaidi",
        "label": "中速快件"
    },
    {
        "value": "zhongtianwanyun",
        "label": "中天万运"
    },
    {
        "value": "zhongruisudi",
        "label": "中睿速递"
    },
    {
        "value": "zhongwaiyun",
        "label": "中外运速递"
    },
    {
        "value": "zengyisudi",
        "label": "增益速递"
    }
]);

function getRandom(){
    var Num="";
    for(var i=0;i<16;i++){
    Num+=Math.floor(Math.random()*10);
    }
    Num = "0."+Num;

    return Num;
}

function getCurrentTime(){
    var d = new Date();
    var year = d.getFullYear();
    var mon = d.getMonth()+1;
    var day=d.getDate();
    return year+"-"+mon+"-"+day
}

function getLabel(postname){
  for ( var i in allpost   ){
      if(postname == allpost[i].value){
        return allpost[i].label
      }
  }
}
