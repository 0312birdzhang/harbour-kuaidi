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

    id:showdetail
    property var id
    property string name
    property string postid
    property string wuliutype
    property string description
    property string postinfo:""
    property string highlightedpostinfo: ""
    property int operationType: PageStackAction.Animated
    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted

    Component.onCompleted: {
        // description = ST.getKuaidiInfo(id);
        py.getpostinfo(wuliutype, postid)
    }


    SilicaFlickable{
        id:view
        anchors.fill: parent
        contentHeight: header.height+descLabel.height+desc.height
                        +postLabel.height+postinfoLabel.height
                        +highlightLabel.height+ Theme.paddingLarge*2

        PageHeader {
            id:header
            title: "物流信息"
        }
        PullDownMenu{
            MenuItem{
                text:"刷新"
                onClicked: {
                    py.getpostinfo(wuliutype, postid);
                }
            }
        }

        Separator {
            width:parent.width - descLabel.width;
            color: Theme.highlightColor
            anchors{
                right: descLabel.left
                top:descLabel.top
                topMargin: descLabel.height/2
                margins: Theme.paddingLarge
            }
        }
        Label{
            id:descLabel
            text:"备注"
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            anchors{
                right: parent.right
                top:header.bottom
                margins: Theme.paddingLarge
            }
        }

        Label{
            id:desc
            width: parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeExtraSmall
            truncationMode: TruncationMode.Fade
            text: description
            color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
            anchors{
                top:descLabel.bottom
                //horizontalCenter: parent.horizontalCenter
                left:parent.left
                right:parent.right
                margins: Theme.paddingLarge
            }
        }
        Separator {
            width:parent.width - postLabel.width;
            color: Theme.highlightColor
            anchors{
                left: parent.left
                right: postLabel.left
                top:postLabel.top
                topMargin: postLabel.height/2
            }
        }
        Label{
            id:postLabel
            text:"物流"
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            anchors{
                margins: Theme.paddingLarge
                top:desc.bottom
                right: parent.right
            }
        }
        Label{
            id:highlightLabel
            anchors{
                left:parent.left
                right:parent.right
                top:postLabel.bottom
                margins: Theme.paddingLarge
            }

            wrapMode: Text.WordWrap
            width: parent.width
            text: highlightedpostinfo
            color: Theme.highlightColor
        }
        Label{
            id: postinfoLabel
            anchors{
                left:parent.left
                right:parent.right
                top:highlightLabel.bottom
                margins: Theme.paddingLarge
            }

            wrapMode: Text.WordWrap
            width: parent.width
            text: postinfo
            color: view.highlighted ? Theme.highlightColor : Theme.primaryColor
        }

        VerticalScrollDecorator{}
    }

    Timer{
        id:processingtimer;
        interval: 30000;
        onTriggered: addNotification("加载失败",3)
    }

}
