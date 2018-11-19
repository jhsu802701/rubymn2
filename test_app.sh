#!/bin/bash

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------'
echo 'rails db:migrate'
rails db:migrate

echo '---------------------------'
echo 'DISABLE_SPRING=1 rails test'
DISABLE_SPRING=1 rails test
