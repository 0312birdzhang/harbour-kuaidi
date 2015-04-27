# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-kuaidi

CONFIG += sailfishapp

SOURCES += src/harbour-kuaidi.cpp

OTHER_FILES += qml/harbour-kuaidi.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/*.qml \
    qml/pages/*.js\
    rpm/harbour-kuaidi.spec \
    rpm/harbour-kuaidi.yaml \
    translations/*.ts \
    harbour-kuaidi.desktop \
    rpm/harbour-kuaidi.changes \
    qml/pages/Notification.qml \
    qml/pages/notifactionbar.png


# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-kuaidi-de.ts

