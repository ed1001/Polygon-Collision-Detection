#!/bin/bash
if ! bundle check >/dev/null 2>/dev/null; then
  echo "installing dependencies..."
  bundle install >/dev/null
fi
ruby main.rb
