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
import "../pages/storage.js" as ST


CoverBackground {
    id:cover
    property var postid

    property var description:""
    property var highlightedpostinfo:""
    property var postinfo: ""
    property var tmpid
    function howLoad(){
        if(mystep == 1){
            ST.themeColor =  Theme.highlightColor;
            description = ST.getKuaidiInfo(coverpostid);
            tmpid = coverpostid;
        }else{
            ST.getKuaidi("three");
        }
    }

    Component.onCompleted: {
        howLoad();
    }

    onStatusChanged: {
        if (status == PageStatus.Active ) {
            if(listModel.count > 0 && mystep == 0){
                ST.getKuaidi("three");
            }else if(description.length == 0){
                howLoad();
            }else if(tmpid != coverpostid){
                howLoad();
            }

            else{
                //console.log("do nothing")
            }
        }
    }

    BusyIndicator {
        id:progress
        running: false
        parent:cover
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }
    ListModel {  id:listModel }

    CoverActionList {
        id: refreshCoverAction

        enabled: mystep == 1

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                ST.themeColor =  Theme.highlightColor;
                description = ST.getKuaidiInfo(coverpostid);
            }
        }
    }
    SilicaListView {
        id:view
        visible: listModel.count>0 && mystep == 0
        anchors.fill:parent
        anchors.topMargin: Theme.paddingLarge
        model : listModel
        clip: true
        delegate:Label{
            wrapMode: Text.WordWrap
            x: Theme.paddingSmall
            maximumLineCount:1
            truncationMode: TruncationMode.Fade
            width: parent.width-Theme.paddingMedium
            text: (model.index+1) + ". " +description
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeTiny
        }
        VerticalScrollDecorator {}

    }

    SilicaFlickable{
        id:filic
        visible: mystep == 1
        anchors.fill: parent
        Label{
            id:desc
            wrapMode: Text.WordWrap
            width: parent.width
            text:"备注:"+description
            font.pixelSize: Theme.fontSizeMedium
            color:  Theme.highlightColor
            anchors{
                left:parent.left
                right:parent.right
                top:parent.top
                margins: Theme.paddingLarge
            }

        }

        Label{
            id:postinfoLabel
            anchors{
                left:parent.left
                right:parent.right
                top:desc.bottom
                margins: Theme.paddingLarge
            }

            wrapMode: Text.WordWrap
            width: parent.width
            text: highlightedpostinfo.length > 4?highlightedpostinfo:"暂未查询到最新记录，请稍后重试O(∩_∩)O"
            font.pixelSize: Theme.fontSizeExtraSmall
            color: cover.highlighted ? Theme.highlightColor : Theme.primaryColor
        }

        VerticalScrollDecorator{}

    }

    CoverPlaceholder{
      icon.source:"../harbour-kuaidi.png"
      text:"我的快递"
      visible: (listModel.count>0 && mystep == 0 )|| listModel.count == 0
    }
    // Image{
    //     id:logo
    //     visible: (listModel.count>0 && mystep == 0 )|| listModel.count == 0
    //     fillMode: Image.Stretch;
    //     source:"../harbour-kuaidi.png"
    //     anchors.centerIn: parent
    //     anchors.topMargin: Theme.paddingLarge*2
    // }
    // Label{
    //     visible:  (listModel.count>0 && mystep == 0 )|| listModel.count == 0
    //     text:"我的快递"
    //     anchors.top:logo.bottom
    //     anchors.topMargin: Theme.paddingLarge
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     //color: Theme.highlightColor
    // }

}
