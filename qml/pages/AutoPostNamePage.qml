import QtQuick 2.0
import Sailfish.Silica 1.0
import "./allposts.js" as Posts

Page{
    id:secondWizardPage
    property string postid
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    Component.onCompleted: {
        py.queryVendor(postid);
    }

    Connections{
        target: signalCenter;
        // {"comCode":"","num":"xxxxx","auto":[{"comCode":"ecmscn","lengthPre":16,"noCount":291823,"noPre":"ESF"}]}
        onGetvendor:{
            if(vendjson){
                var comCode = vendjson.auto[0].comCode;
                autopostModel.append({
                              "value": comCode,
                              "label": Posts.getLabel(comCode)
                            })
            }else{
                for ( var i in Posts.allpost ){
                    autopostModel.append({"label":Posts.allpost[i].label,
                                        "value":Posts.allpost[i].value
                                    });
                }
            }
        }
    }


    ListModel {  id: autopostModel }

    BusyIndicator {
            id:progress
            running: !PageStatus.Active
            parent:secondWizardPage
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
     }

    SilicaListView {
        id:view
        anchors.fill:parent
        header: PageHeader {
            id:header
            title: "选择快递商"
        }
        width:parent.width
        model : autopostModel
        clip: true
        delegate:ListItem {
            Label{
                id:showprocess
		        anchors.verticalCenter:parent.verticalCenter
                wrapMode: Text.WordWrap
                x:Theme.paddingLarge
                maximumLineCount:2
                truncationMode: TruncationMode.Fade
                width: parent.width-Theme.paddingLarge *2
                text: (model.index+1) + ". "+label
                color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                pageStack.push(Qt.resolvedUrl("ShowPage.qml"),
                               {
                                   "wuliutype":value,
                                   "postid":postid,
                                   "wuliuming":label
                               })
                    }
        }
        VerticalScrollDecorator {}

        ViewPlaceholder{
            enabled: view.count == 0
            text:"没有根据快递单号查询到快递商，将展示全部"
            MouseArea{
              anchors.fill:parent
            }
        }
    }
}
