import QtQuick 2.0
import Sailfish.Silica 1.0
import "./parser.js" as JS
import "./allposts.js" as Posts

Page{
    id:secondWizardPage
    property string postid
    property int modelCount: view.count
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    onModelCountChanged: {
        if(view.count == 1){
            pageStack.push(Qt.resolvedUrl("ShowPage.qml"),
                         {
                             "wuliutype":autopostModel.get(0).value,
                             "postid":postid,
                             "wuliuming":autopostModel.get(0).label
                         })
        }
    }

    Component.onCompleted: {
        JS.autopostModel = autopostModel
        JS.getPostname(postid)

    }

    function fillPosts(){
      for ( var i in Posts.allpost   ){
            postnames.append({"label":Posts.allpost[i].label,
                                 "value":Posts.allpost[i].value
                             });
        }
        view.model = postnames
    }

    ListModel {  id:autopostModel }
    ListModel {  id: postnames    }

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
        header:PageHeader {
            id:header
            title: "选择快递商"
        }
        width:parent.width
        model : autopostModel
        clip: true
        delegate:ListItem {
            Label{
                id:showprocess
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
            //id:nohistory
            enabled: view.count == 0 && !PageStatus.Active
            text:"没有根据快递单号查询到快递商，点击切换手动选择模式"
            MouseArea{
              anchors.fill:parent
              onClicked : fillPosts()
            }
        }
    }
}
