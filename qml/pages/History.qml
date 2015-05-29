/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.0
import "storage.js" as ST
import Sailfish.Silica 1.0
Page{
    id:historypage
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    Component.onCompleted: {
            ST.initialize();
            ST.getKuaidi("all");
            mystep = 0;
        }
    onStatusChanged: {
        if (status == PageStatus.Active) {
            mystep =0;
        }
    }
    //onOrientationChanged: ST.getKuaidi("all")

        ListModel {  id:listModel }

        SilicaListView {
            id:view
            anchors.fill:parent
            visible: listModel.count > 0
            header:PageHeader {
                id:header
                title: "查询历史"
            }
            width:parent.width
            model : listModel
            clip: true
            delegate:ListItem {
                            menu: contextMenuComponent
                            function remove(id) {
                                remorseAction("正在删除...", function() {
                                    listModel.remove(index);
                                    ST.clearKuaidi(id);
                                })
                            }

                        ListView.onRemove: animateRemoval()
                        Label{
                           id:showprocess
                           wrapMode: Text.WordWrap
                           x:Theme.paddingLarge
                           maximumLineCount:1
                           truncationMode: TruncationMode.Fade
                           width: parent.width-Theme.paddingLarge *2
                           text: (model.index+1) + ". "+description
                           color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
                        }
                        Label{
                            id:postinfo
                            width: parent.width-Theme.paddingLarge
                            text:{
                                if(posttime&&posttime.length >2){
                                    return name+":"+postid+",保存时间:"+posttime
                                }else{
                                    return name+":"+postid
                                }
                            }
                            color: Theme.highlightColor
                            font.pixelSize: Theme.fontSizeTiny
                            font.italic :true
                            anchors{
                                top:showprocess.bottom
                                left:parent.left
                                right:parent.right
                                leftMargin: Theme.paddingLarge*2
                            }
                        }

                        Component {
                            id: contextMenuComponent
                            ContextMenu {
                                id:contextMenu
                                MenuItem {
                                    text: "编辑"
                                    onClicked: {
                                        pageStack.push(updatePage,{"id":id,"postid":postid,"description":description})
                                    }
                                }
                                MenuItem {
                                    text: "删除"
                                    onClicked: remove(id)
                                }
                            }
                        }
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("HistoryDetail.qml"),
                                                { "id":id,
                                               "wuliutype":name,
                                               "postid":postid
                                                    })

                       }


                   VerticalScrollDecorator {}

        }



    }
     Component {
            id: updatePage
        Dialog {
            id:editDialog
            property var id :""
            property var postid:""
            property var description :""
            canAccept: subcomments.text.length > 0 && postid.text.length >0
            acceptDestination: historypage
            acceptDestinationAction: PageStackAction.Pop
            allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

            onAccepted: {
                var test = ST.updateKuaidi(id,postid.text,subcomments.text);
                if(test === "OK"){
                    ST.getKuaidi("all")
                    addNotification("更新成功", 3)
                }else{
                    addNotification("更新失败", 3)
                }
            }

           SilicaFlickable {

                width: parent.width
                height: parent.height
                interactive: false
                anchors.fill: parent
                contentHeight: column.height
                Column{
                    id: column
                    width: parent.width
                    height: rectangle.height
                    DialogHeader {

                    }
                    anchors{
                        //top:dialogHead.bottom
                        left:parent.left
                        right:parent.right
                    }

                    spacing: Theme.paddingLarge
                    Rectangle{
                        id:rectangle
                        width: parent.width-Theme.paddingLarge
                        height: subcomments.height + postid.height + Theme.paddingLarge*3
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color:Theme.highlightColor
                        color:"#00000000"
                        radius: 30
                        TextArea {
                            id:postid
                            anchors{
                                topMargin: Theme.paddingMedium
                            }
                            text:editDialog.postid
                            width:Screen.width - Theme.paddingLarge*4
                            height: Math.max(Theme.itemSizeMedium,implicitHeight)
                            font.pixelSize: Theme.fontSizeMedium
                            placeholderText: "编辑您的快递单号"
                            label: "单号"
                        }
                        TextArea {
                            id:subcomments
                            anchors{
                                bottom:rectangle.bottom
                                topMargin: Theme.paddingMedium
                            }
                            text:editDialog.description
                            width:Screen.width - Theme.paddingLarge*4
                            height: Math.max(Screen.width/3, implicitHeight)
                            font.pixelSize: Theme.fontSizeMedium
                            placeholderText: "编辑您的备注"
                            label: "备注"
                        }

                    }

                }



            }
        }
    }
        Label{
            id:nohistory
            visible: listModel.count===0
            text:"暂无历史记录"
            anchors.centerIn: parent
            font.pixelSize: Theme.fontSizeExtraLarge
        }
}
