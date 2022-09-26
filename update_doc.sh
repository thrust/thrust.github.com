#!/usr/bin/env bash

THRUST_HOME="thrust/"

if [ ! -d "$THRUST_HOME" ]; then
  echo "$THRUST_HOME does not exist."
  echo "Clone the https://github.com/NVIDIA/thrust/ repository to $THRUST_HOME directory"
  exit 1
fi

cd $THRUST_HOME && \
  git apply ../doxygen_html.patch && \
  rm -f ../doc/*.html && \
  doxygen docs/doxygen/config.dox && \
  git apply -R ../doxygen_html.patch && \
  cd - || \
  echo "Doxygen Documentation update failed"

