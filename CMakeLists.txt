# Copyright 2014, MY NAME
#
# This file is part of a free library: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details. You should have
# received a copy of the GNU General Public License along with
# this library. If not, see <http://www.gnu.org/licenses/>.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

#Define the project
SET(PROJECT_NAME MyProjectName)
SET(PROJECT_DESCRIPTION "")
SET(PROJECT_URL "")
SET(PROJECT_VERSION "0.0.1")
SET(PROJECT_REQUIREMENTS "")

SET(CUSTOM_HEADER_DIR "${PROJECT_NAME}")

SET(CXX_DISABLE_WERROR 1)

#Options
OPTION(INSTALL_BINARIES "Install binaries." FALSE)
OPTION(ENABLE_TEST "Enable test" FALSE)

#Find packages
#FIND_PACKAGE(PackageName REQUIRED)

#Include directories
include_directories( ${CMAKE_SOURCE_DIR}/include/ )

#Build binaries
IF(EXISTS ${CMAKE_SOURCE_DIR}/bin)
  ADD_SUBDIRECTORY(bin)
ENDIF()

#Build tests
IF(EXISTS ${CMAKE_SOURCE_DIR}/test)
  ADD_SUBDIRECTORY(test)
ENDIF()

#Build unit testing
IF(ENABLE_TEST)
  ENABLE_TESTING()
  IF(EXISTS ${CMAKE_SOURCE_DIR}/unitTesting)
    ADD_SUBDIRECTORY(unitTesting)
  ENDIF()
ENDIF(ENABLE_TEST)

#Install complete
IF(INSTALL_BINARIES)
  OPTION(INSTALL_COMPLETE "Install completion files." FALSE)
  IF(INSTALL_COMPLETE)
    IF(EXISTS ${CMAKE_SOURCE_DIR}/complete)
      SET(COMPLETION_DIR /etc/bash_completion.d/ CACHE PATH "Completion folder")
      file(GLOB ${PROJECT_NAME}_COMPLETE complete/*.sh)
      INSTALL(FILES ${${PROJECT_NAME}_COMPLETE}
	DESTINATION ${COMPLETION_DIR}
        PERMISSIONS OWNER_READ GROUP_READ WORLD_READ OWNER_WRITE
      )
    ENDIF()
  ENDIF(INSTALL_COMPLETE)
ENDIF(INSTALL_BINARIES)

#Create documentation
FIND_PACKAGE( Doxygen )

IF(DOXYGEN_FOUND)
  CONFIGURE_FILE(${CMAKE_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/doc/Doxyfile )
  add_custom_target(doc
  ${DOXYGEN_EXECUTABLE} ${PROJECT_BINARY_DIR}/doc/Doxyfile
  COMMENT "Generating API documentation with Doxygen" VERBATIM)
ENDIF(DOXYGEN_FOUND)
