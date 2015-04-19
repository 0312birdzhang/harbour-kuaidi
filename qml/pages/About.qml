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
    id: aboutpage

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: column.height
        //contentWidth: column.width

        Column {
            id:column
            PageHeader {
                title: "关于"
            }

            spacing: Theme.paddingSmall

            width: parent.width

            //author info
            Label {

                anchors {
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width - (2 * Theme.paddingLarge)
                wrapMode: Text.Wrap
                text: qsTr("作者:0312birdzhang")
            }
            Label {
                anchors {
                    right: parent.right
                   rightMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.Wrap
                width: parent.width - (2 * Theme.paddingLarge)
                text: "源码地址：https://github.com/0312birdzhang/harbour-kuaidi"
            }



            Separator {
                width:parent.width;
                color: Theme.highlightColor
            }

            //credit label
            Item {
                height: creditLabel.height
                anchors {
                    left: parent.left
                    right: parent.right
                }
                Label {
                    id:creditLabel
                    anchors{
                        right: parent.right
                        rightMargin: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeLarge
                    text: "感谢"
                }
            }

            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                 font.pixelSize: Theme.fontSizeSmall
                width: parent.width - (2 * Theme.paddingLarge)
                wrapMode: Text.Wrap
                text: "感谢www.kuaidi100.com的免费接口"
            }
            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width - (2 * Theme.paddingLarge)
                wrapMode: Text.Wrap
                text: "感谢蝉曦的帮助，解决了困扰我很久的键盘隐藏问题"
            }
            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width - (2 * Theme.paddingLarge)
                wrapMode: Text.Wrap
                text: "感谢梦影决幻为本软件制作的图标 "
            }
            Separator {
                width:parent.width;
                color: Theme.highlightColor
            }
            Item {
                height: changelog.height
                anchors {
                    left: parent.left
                    right: parent.right
                }
                Label {
                    id:changelog
                    anchors{
                        right: parent.right
                        rightMargin: Theme.paddingLarge
                    }
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeLarge
                    text: "更新说明"
                }
            }
            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.paddingLarge
                }
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeTiny*1.5
                width: parent.width - (2 * Theme.paddingLarge)
                wrapMode: Text.Wrap
                text:"v0.8 添加所有的快递商.更改单号默认输入法<br/>"
                    +"v0.7 修复物流信息不能滑动的bug;添加保存消息提示;修改备注输入框样式.<br/>"
                    +"v0.6 修改连续保存提示已经保存过的bug;添加备注，第一次使用会保存不进去，再保存一次即可.<br/>"
                    +"v0.5 在cover页面添加最近三条查询记录，去掉订单错误代码的情况下不能保存的校验<br/>"
                    +"v0.4 优化查询首页UI,更改保存订单方式为下拉菜单等"
            }
        }
    }

}
