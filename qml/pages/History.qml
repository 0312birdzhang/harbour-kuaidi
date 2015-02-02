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
    property var  wuliutype
    property var postid

        Component.onCompleted: {
            ST.initialize()
            ST.getKuaidi()
        }

        ListModel {  id:listModel }


        SilicaListView {
            id:view
            anchors.fill:parent
            header:PageHeader {
                id:header
                title: "查询历史"
            }
            model : listModel
            clip: true
            delegate:ListItem {
                            menu: contextMenuComponent
                            function remove(id) {
                                remorseAction("正在删除 ", function() {
                                    listModel.remove(index);
                                    ST.clearKuaidi(id);
                                })
                            }
                         ListView.onRemove: animateRemoval()
                        Text{
                           id:showprocess
                           wrapMode: Text.WordWrap
                           x: Theme.paddingLarge
                           width: root.width-20
                           text: (model.index+1) + ". " +name+":"+postid+"<br/>"
                           color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
                        }
                        Component {
                            id: contextMenuComponent
                            ContextMenu {
                                MenuItem {
                                    text: "删除"
                                    onClicked: remove(id)
                                }
                            }
                        }
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("HistoryDetail.qml"), { "id":id})

                       }


                   VerticalScrollDecorator {}

        }



    }
}
