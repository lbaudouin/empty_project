# Copyright 2014, MY NAME
#
# This file is part of a free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# This software is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details. You should have
# received a copy of the GNU General Public License along with
# this software. If not, see <http://www.gnu.org/licenses/>.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

#Define the project
SET(PROJECT_NAME MyProjectName)
SET(PROJECT_DESCRIPTION "")
SET(PROJECT_URL "")
SET(PROJECT_VERSION "0.0.1")
SET(PROJECT_REQUIREMENTS "")

#SET(CUSTOM_HEADER_DIR "${PROJECT_NAME}")

#Set default build type
IF (NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
    FORCE)
ENDIF (NOT CMAKE_BUILD_TYPE)

#Set CXX parameters
SET(CXX_DISABLE_WERROR 1)

#Options
OPTION(BUILD_TEST "Build test" FALSE)
OPTION(INSTALL_DOC "Install documentation." TRUE)
OPTION(INSTALL_BINARIES "Install binaries." FALSE)

#Find packages
#FIND_PACKAGE( PackageName [VERSION] [EXACT] [REQUIRED] )
#IF(PackageName_FOUND)
#  INCLUDE_DIRECTORIES( PackageName_INCLUDE_DIRS )
#  LINK DIRECTORIES( PackageName_LIBRARY_DIRS )
#ENDIF(PackageName_FOUND)

#Configuration
SET(${PROJECT_NAME}_CXXFLAGS "")
SET(${PROJECT_NAME}_LIBS "")

#Include directories
include_directories( ${CMAKE_SOURCE_DIR}/include/ )

#Definition
#add_definitions( "-DMY_DEFINITION" )
#Usage in C/C++:
#        #ifdef MY_DEFINITION
#          ...
#        #endif

#Set sources files
file(GLOB ${PROJECT_NAME}_SRCS src/*.cpp)

#Set headers files
file(GLOB ${PROJECT_NAME}_HDRS include/*.h)

#Build binaries
IF(EXISTS ${CMAKE_SOURCE_DIR}/bin/CMakeLists.txt)
  ADD_SUBDIRECTORY(bin)
ENDIF()

#Build tests
IF(EXISTS ${CMAKE_SOURCE_DIR}/test/CMakeLists.txt)
  ADD_SUBDIRECTORY(test)
ENDIF()

#Build unit testing
IF(BUILD_TEST)
  ENABLE_TESTING()
  IF(EXISTS ${CMAKE_SOURCE_DIR}/unitTesting/CMakeLists.txt)
    ADD_SUBDIRECTORY(unitTesting)
  ENDIF()
ENDIF(BUILD_TEST)

#Create documentation
FIND_PACKAGE( Doxygen )

IF(DOXYGEN_FOUND)
  CONFIGURE_FILE(${CMAKE_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/doc/Doxyfile )
  #Add doc target
  ADD_CUSTOM_TARGET(doc
  ${DOXYGEN_EXECUTABLE} ${PROJECT_BINARY_DIR}/doc/Doxyfile
  COMMENT "Generating API documentation with Doxygen" VERBATIM)
  IF(INSTALL_DOC)
    #Force build doc before install
    INSTALL( CODE "EXEC_PROGRAM(${CMAKE_BUILD_TOOL}  ARGS doc)" )
    #Install documentation
    INSTALL(DIRECTORY ${PROJECT_BINARY_DIR}/doc/html/
	    DESTINATION ${CMAKE_INSTALL_PREFIX}/share/doc/${PROJECT_NAME}
	  )
  ENDIF(INSTALL_DOC)
ENDIF(DOXYGEN_FOUND)
