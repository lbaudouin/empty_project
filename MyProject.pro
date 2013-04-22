TEMPLATE = app
CONFIG -= qt gui console app_bundle

TARGET = MyExecutable

SOURCES += bin/main.cpp \
    src/my_class.cpp

HEADERS += include/my_class.h

OTHER_FILES += \
    README \
    CMakeLists.txt \
    complete/mycompletion.sh
