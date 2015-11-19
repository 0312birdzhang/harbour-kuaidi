import QtQuick 2.0
import Sailfish.Silica 1.0
import "storage.js" as ST
Page {
    id: updatePage
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted
   Column{
       anchors.fill: parent
    Dialog {
        property string postid :""
        property string description :""
        canAccept: subcomments.text.length > 0
        acceptDestination: Qt.resolvedUrl("History.qml")
        acceptDestinationAction: PageStackAction.Pop
        allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

        onAccepted: {
            var test = ST.updateKuaidi(id,subcomments.text);
            if(test === "OK"){
                addNotification("更新成功", 3)
            }else{
                addNotification("更新失败", 3)
            }
        }

        SilicaFlickable {
            // ComboBox requires a flickable ancestor
            width: parent.width
            height: parent.height
            interactive: false
            anchors.fill: parent
            Column{
                id: column
                width: parent.width
                height: rectangle.height

                anchors{
                    //top:dialogHead.bottom
                    left:parent.left
                    right:parent.right
                }

                spacing: Theme.paddingLarge
                Rectangle{
                    id:rectangle
                    width: parent.width-Theme.paddingLarge
                    height: subcomments.height + Theme.paddingLarge*3
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color:Theme.highlightColor
                    color:"#00000000"
                    radius: 30
                    TextArea {
                        id:subcomments
                        anchors{
                            bottom:rectangle.bottom
                            topMargin: Theme.paddingMedium
                        }
                        text:description
                        width:window.width - Theme.paddingLarge*4
                        height: Math.max(updatePage.width/3, implicitHeight)
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "编辑您的备注"
                        label: "备注"
                    }

                }

            }



        }
    }
   }
}
