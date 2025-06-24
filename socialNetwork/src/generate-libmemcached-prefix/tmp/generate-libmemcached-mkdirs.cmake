# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/palaharsh/DeathStarBench/socialNetwork/downloads/libmemcached"
  "/home/palaharsh/DeathStarBench/socialNetwork/build-libmemcached"
  "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix"
  "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix/tmp"
  "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix/src/generate-libmemcached-stamp"
  "/home/palaharsh/DeathStarBench/socialNetwork/downloads"
  "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix/src/generate-libmemcached-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix/src/generate-libmemcached-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/palaharsh/DeathStarBench/socialNetwork/src/generate-libmemcached-prefix/src/generate-libmemcached-stamp${cfgdir}") # cfgdir has leading slash
endif()
