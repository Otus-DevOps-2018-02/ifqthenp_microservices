.EXPORT_ALL_VARIABLES:
USER_NAME = ifqthenp

all: build push

build: build_ui build_comment build_post build_prometheus build_mongodb_exporter build_blackbox_exporter build_alertmanager build_telegraf build_fluentd
build_ui:
	cd src/ui && bash docker_build.sh
build_comment:
	cd src/comment && bash docker_build.sh
build_post:
	cd src/post-py && bash docker_build.sh
build_prometheus:
	docker build -t $(USER_NAME)/prometheus monitoring/prometheus
build_mongodb_exporter:
	docker build -t $(USER_NAME)/mongodb_exporter monitoring/mongodb_exporter
build_blackbox_exporter:
	docker build -t $(USER_NAME)/blackbox_exporter monitoring/blackbox_exporter
build_alertmanager:
	docker build -t $(USER_NAME)/alertmanager monitoring/alertmanager
build_telegraf:
	docker build -t $(USER_NAME)/telegraf monitoring/telegraf
build_fluentd:
	docker build -t $(USER_NAME)/fluentd logging/fluentd

push: push_ui push_comment push_post push_prometheus push_mongodb_exporter push_blackbox_exporter push_alertmanager push_telegraf push_fluentd
push_ui:
	docker push $(USER_NAME)/ui
push_comment:
	docker push $(USER_NAME)/comment
push_post:
	docker push $(USER_NAME)/post
push_prometheus:
	docker push $(USER_NAME)/prometheus
push_mongodb_exporter:
	docker push $(USER_NAME)/mongodb_exporter
push_blackbox_exporter:
	docker push $(USER_NAME)/blackbox_exporter
push_alertmanager:
	docker push $(USER_NAME)/alertmanager
push_telegraf:
	docker push $(USER_NAME)/telegraf
push_fluentd:
	docker push $(USER_NAME)/fluentd

.PHONY: all build build_ui build_comment build_post build_prometheus build_mongodb_exporter build_blackbox_exporter build_alertmanager build_telegraf build_fluentd push push_ui push_comment push_post push_prometheus push_mongodb_exporter push_blackbox_exporter push_alertmanager push_telegraf push_fluentd
