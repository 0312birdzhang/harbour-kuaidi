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
import Sailfish.Silica 1.0


Page {
    id: page
    property int operationType: PageStackAction.Animated

    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("关于")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }
        contentHeight: column.height
        ListModel {
            id: orientationLockModel
            ListElement {
                label: "申通"
                value: "shentong"
            }
            ListElement {
                label: "EMS"
                value: "ems"
            }
            ListElement {
                label: "顺丰"
                value: "shunfeng"
            }
            ListElement {
                label: "圆通"
                value: "yuantong"
            }
            ListElement {
                label: "中通"
                value: "zhongtong"
            }
            ListElement {
                label: "韵达"
                value: "yunda"
            }
            ListElement {
                label: "天天"
                value: "tiantian"
            }
            ListElement {
                label: "汇通"
                value: "huitongkuaidi"
            }
            ListElement {
                label: "全峰"
                value: "quanfengkuaidi"
            }
            ListElement {
                label: "德邦"
                value: "debangwuliu"
            }
            ListElement {
                label: "宅急送"
                value: "zhaijisong"
            }
        }

        MouseArea{
            anchors.fill: parent;
            onClicked: {
                postid.focus=false;
            }
        }

        Column {
            id: column
            x:orientationLockCombo.x
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "我的快递"
            }
            Rectangle{
                id:rectangle
                width: input.width + Theme.paddingMedium*2-Theme.paddingSmall
                height: input.height + Theme.paddingMedium*2
                anchors.horizontalCenter: parent.horizontalCenter
                border.color:Theme.highlightColor
                color:"#00000000"
                radius: 30
                Column {
                    id:input
                    anchors{
                        top:rectangle.top
                        topMargin: Theme.paddingMedium
                    }

                    spacing: Theme.paddingMedium
                    ComboBox {
                        id: orientationLockCombo
                        label:"选择快递商"
                        menu: ContextMenu {
                            Repeater {
                                model: orientationLockModel
                                MenuItem {
                                    text: label
                                }
                            }
                        }

                    }
                    TextField {
                        id:postid
                        width:page.width - Theme.paddingLarge*4
                        height:implicitHeight
                        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText
                        echoMode: TextInput.Normal
                        font.pixelSize: Theme.fontSizeMedium
                        placeholderText: "请输入快递号"
                        label: "快递号"
                    }
                    Row{
                        id:buttons
                        spacing: Theme.paddingLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            text: "查询"
                            onClicked: {
                                postid.focus=false;
                                if(postid.text&&postid.text.length>2){
                                    postid.placeholderText="请输入快递号";
                                    pageStack.push(Qt.resolvedUrl("ShowPage.qml"),
                                                   {
                                                       "wuliutype":orientationLockModel.get(orientationLockCombo.currentIndex).value,
                                                       "postid":postid.text,
                                                       "wuliuming":orientationLockCombo.value
                                                   });
                                }
                                else{
                                    postid.placeholderColor="red";
                                }
                            }
                        }
                        Button {
                            text: "历史记录"
                            onClicked: {
                                postid.focus=false;
                                pageStack.push(Qt.resolvedUrl("History.qml") );
                            }
                        }
                    }
                }

            }


        }


    }

}



