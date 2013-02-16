#!/bin/bash
cd /home/vasea/work/photoApp/front
hem build -d
cd /home/vasea/work/photoApp/server
sudo rm -R  app/cache
cp /home/vasea/work/photoApp/front/public/application.css /home/vasea/work/photoApp/server/src/Acme/AppBundle/Resources/public/css/style.css
cp /home/vasea/work/photoApp/front/public/application.js /home/vasea/work/photoApp/server/src/Acme/AppBundle/Resources/public/js/app.js
composer install
sudo chmod -R 0777 app/cache