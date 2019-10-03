# =======================================
# Local commands
# =======================================

start:
	yarn
	cd web/wp-content/themes/{{theme-dir}} && yarn
	yarn --silent start

start-clone:
	yarn
	cd web/wp-content/themes/{{theme-dir}} && yarn
	yarn --silent start
	yarn --silent db:pull
	yarn --silent assets:pull
	yarn --silent db:replace

up:
	docker-compose up -d

stop:
	docker-compose stop

update:
	yarn --silent start

rebuild:
	docker-compose stop
	docker-compose rm -f web
	docker-compose rm -f db
	make start

web-bash:
	docker-compose exec web bash

db-bash:
	docker-compose exec db bash

assets-pull:
	yarn --silent assets:pull

db-backup:
	yarn --silent db:backup

db-pull:
	yarn --silent db:backup
	yarn --silent db:pull

db-replace:
	yarn --silent db:backup
	yarn --silent db:replace

db-replace-clone:
	yarn --silent db:backup
	yarn --silent db:pull
	yarn --silent db:replace

regenerate-thumbnails:
	docker-compose exec web bash -c "wp media regenerate --yes --allow-root"

replace-special-characters: 
	docker-compose exec web bash -c "wp search-replace 'Ã„' 'Ä' --allow-root && \
	  wp search-replace 'Ã¤' 'ä' --allow-root && \
	  wp search-replace 'â€' '”' --allow-root && \
	  wp search-replace 'â€“' '–' --allow-root && \
	  wp search-replace 'â€”' '—' --allow-root && \
		wp search-replace 'Ã¶' 'ö' --allow-root"

composer:
	docker run --rm --volumes-from={{name}}-web --workdir=/var/www/html/ composer/composer:alpine $(c)


# =======================================
# Remote commands
# =======================================

production-start:
	yarn --silent production:start

production-db-replace-clone:
	yarn --silent production:db:replace

production-update:
	yarn --silent production:update

production-assets-push:
	yarn --silent production:assets:push
