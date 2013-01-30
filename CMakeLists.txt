# Copyright 2013, MY NAME
#
# This file is part of reconstruction3D.
# reconstruction3D is free software: you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# reconstruction3D is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Lesser Public License for more details.  You should have
# received a copy of the GNU Lesser General Public License along with
# reconstruction3D. If not, see <http://www.gnu.org/licenses/>.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)


SET(PROJECT_NAME MyProjectName)
SET(PROJECT_DESCRIPTION "")
SET(PROJECT_URL "")

SET(CUSTOM_HEADER_DIR "${PROJECT_NAME}")

SET(CXX_DISABLE_WERROR 1)

FIND_PACKAGE( Doxygen )

ADD_SUBDIRECTORY(bin)
ADD_SUBDIRECTORY(test)

add_custom_target(doc
${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile
COMMENT "Generating API documentation with Doxygen" VERBATIM)





