build-proto:
	protoc -I.  \
	--js_out=import_style=commonjs_strict,binary:pb/js proto/*.proto

build-typescript-proto:
	protoc \
		-Iproto \
    --plugin="protoc-gen-ts=${PWD}/node_modules/.bin/protoc-gen-ts" \
    --js_out="import_style=commonjs_strict,binary:./generated" \
    --ts_out="./generated" \
    proto/*.proto

build-grpc:
	${PWD}/node_modules/.bin/grpc_tools_node_protoc \
		-Iproto \
    --plugin="protoc-gen-ts=${PWD}/node_modules/.bin/protoc-gen-ts" \
		--plugin="grpc_tools_node_protoc_plugin=${PWD}/node_modules/.bin/grpc_tools_node_protoc_plugin" \
    --js_out="import_style=typescript,binary:./pb/static" \
    --ts_out="./pb/static" \
		--grpc_out="grpc_js:./pb/static" \
    proto/*.proto

build-grpc1:
	protoc \
		-Iproto \
		--plugin="protoc-gen-ts=${PWD}/node_modules/.bin/protoc-gen-ts" \
		--plugin="protoc-gen-grpc=${PWD}/node_modules/.bin/grpc_tools_node_protoc_plugin" \
    --js_out="import_style=typescript,binary:./pb/static" \
		--ts_out="service=grpc-node:./pb/static" \
		--grpc_out="generate_package_definition:./pb/static" \
    proto/*.proto

clean:
	rm -rf ${PWD}/pb/static/*