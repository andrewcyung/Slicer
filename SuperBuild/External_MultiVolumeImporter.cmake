# Make sure this file is included only once
get_filename_component(CMAKE_CURRENT_LIST_FILENAME ${CMAKE_CURRENT_LIST_FILE} NAME_WE)
if(${CMAKE_CURRENT_LIST_FILENAME}_FILE_INCLUDED)
  return()
endif()
set(${CMAKE_CURRENT_LIST_FILENAME}_FILE_INCLUDED 1)

# Sanity checks
if(DEFINED MultiVolumeImporter_SOURCE_DIR AND NOT EXISTS ${MultiVolumeImporter_SOURCE_DIR})
  message(FATAL_ERROR "MultiVolumeImporter_SOURCE_DIR variable is defined but corresponds to non-existing directory")
endif()

# Set dependency list
set(MultiVolumeImporter_DEPENDENCIES "")

# Include dependent projects if any
SlicerMacroCheckExternalProjectDependency(MultiVolumeImporter)
set(proj MultiVolumeImporter)

if(NOT DEFINED MultiVolumeImporter_SOURCE_DIR)
  #message(STATUS "${__indent}Adding project ${proj}")
  ExternalProject_Add(${proj}
    GIT_REPOSITORY "${git_protocol}://github.com/fedorov/MultiVolumeImporter.git"
    GIT_TAG "6e972073bad99cb9e51629ca3d4dbc2c1ce85589"
    SOURCE_DIR ${CMAKE_BINARY_DIR}/${proj}
    BINARY_DIR ${proj}-build
    UPDATE_COMMAND ""
    CMAKE_GENERATOR ${gen}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    DEPENDS
      ${MultiVolumeImporter_DEPENDENCIES}
    )
  set(MultiVolumeImporter_SOURCE_DIR ${CMAKE_BINARY_DIR}/${proj})
else()
  # The project is provided using MultiVolumeImporter_DIR, nevertheless since other project may depend on EMSegment,
  # let's add an 'empty' one
  SlicerMacroEmptyExternalProject(${proj} "${MultiVolumeImporter_DEPENDENCIES}")
endif()

