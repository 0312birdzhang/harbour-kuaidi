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
import "pages"
import "pages/storage.js" as ST
import Nemo.Notifications 1.0
import io.thp.pyotherside 1.5

ApplicationWindow
{
    id: window
    property bool loading: false

    allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Component.onCompleted: {
        ST.initialize();
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: loading
        size: BusyIndicatorSize.Large
    }

    Notification{
        id:notification
        appName: "我的快递"
    }

    Timer{
        id:processingtimer;
        interval: 40000;
        onTriggered: signalCenter.loadFailed(qsTr("Request timeout"));
    }
    
    Connections{
        target: signalCenter;
        onLoadStarted:{
            window.loading=true;
            processingtimer.restart();
        }
        onLoadFinished:{
            window.loading=false;
            processingtimer.stop();
        }
        onLoadFailed:{
            window.loading=false;
            processingtimer.stop();
            notification.show(errorstring);
        }
    }



    SignalCenter{
        id: signalCenter
    }


    function addNotification(message) {
        notification.previewBody = "我的快递";
        notification.previewSummary = message;
        notification.close();
        notification.publish();
    }

    Python{
      id: py
      Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./pages'))
            py.importModule('parser', function () {
                
            });
      }
      function queryVendor(postid){
        signalCenter.loadStarted();
        py.call('parser.kuaidi.queryvendor',[postid], function(ret){
            signalCenter.getvendor(ret);
            signalCenter.loadFinished();
        })
      }

      function getpostinfo(posttype,postid){
          signalCenter.loadStarted();
          py.call('parser.kuaidi.getpostinfo',[posttype,postid], function(ret){
            signalCenter.getpostinfo(ret);
            signalCenter.loadFinished();
          })
      }

    }
}


