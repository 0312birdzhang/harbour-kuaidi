import QtQuick 2.0
import Sailfish.Silica 1.0
import "./parser.js" as JS
import "./allposts.js" as Posts

Page{
    id:secondWizardPage
    property string postid
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    Component.onCompleted: {
        JS.autopostModel = autopostModel
        JS.getPostname(postid)
    }

    ListModel {  id:autopostModel }

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


            ListView.onRemove: animateRemoval()
            Label{
                id:showprocess
                wrapMode: Text.WordWrap
                x:Theme.paddingLarge
                maximumLineCount:1
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
            enabled: view.count == 0// && !PageStatus.Active
            text:"没有根据快递单号查询到快递商"
        }
    }
}
